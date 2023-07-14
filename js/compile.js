import fs from 'node:fs'
import path from 'node:path'
import url from 'node:url';
import solc from 'solc'

function getRemappings() {
  const directory = path.dirname(url.fileURLToPath(import.meta.url))
  const remappingsPath = path.join(directory, '..', 'remappings.txt')
  if (!fs.existsSync(remappingsPath)) return undefined

  const file = fs.readFileSync(remappingsPath)
  // This process runs in the `src` directory, so update remappings
  return file.toString().trim().split('\n').map((remapping) => {
    const [key, value] = remapping.split('=')
    return `${key}=../${value}`
  })
}

function getSolcInput(source) {
  return {
    language: 'Solidity',
    sources: {
      [path.basename(source)]: {
        content: fs.readFileSync(source, 'utf8'),
      },
    },
    settings: {
      optimizer: {
        enabled: false,
        runs: 1,
      },
      evmVersion: 'london',
      outputSelection: {
        '*': {
          '*': ['abi', 'evm.bytecode'],
        },
      },
      remappings: getRemappings()
    },
  }
}

function findImports(filepath) {
  try {
    const file = fs.existsSync(filepath)
      ? fs.readFileSync(filepath, 'utf8')
      : fs.readFileSync(require.resolve(filepath), 'utf8')
    return { contents: file }
  } catch (error) {
    console.error(error)
    return { error }
  }
}

export default function compile(source) {
  const input = getSolcInput(source)
  process.chdir(path.dirname(source))
  const output = JSON.parse(
    solc.compile(JSON.stringify(input), { import: findImports })
  )

  let errors = []

  if (output.errors) {
    for (const error of output.errors) {
      if (error.severity === 'error') {
        errors.push(error.formattedMessage)
      }
    }
  }

  if (errors.length > 0) {
    throw new Error(errors.join('\n\n'))
  }

  const result = output.contracts[path.basename(source)]
  const contractName = Object.keys(result)[0]
  return {
    abi: result[contractName].abi,
    bytecode: result[contractName].evm.bytecode.object,
  }
}
