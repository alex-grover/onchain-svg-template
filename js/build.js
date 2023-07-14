import fs from 'node:fs/promises'
import os from 'node:os'
import path from 'node:path'
import url from 'node:url'
import { DOMParser } from 'xmldom'
import boot from './boot.js'
import call from './call.js'
import compile from './compile.js'
import deploy from './deploy.js'

const directory = path.dirname(url.fileURLToPath(import.meta.url))
const SOURCE = path.join(directory, '..', 'src', 'Renderer.sol')
const DESTINATION = path.join(os.tmpdir(), 'onchain-svg-template-')

async function main() {
  const { vm, pk } = await boot()
  const { abi, bytecode } = compile(SOURCE)
  const address = await deploy(vm, pk, bytecode)

  const tempFolder = await fs.mkdtemp(DESTINATION)
  console.log('Saving to', tempFolder)

  for (let i = 1; i < 256; i++) {
    const fileName = path.join(tempFolder, i + '.svg')
    console.log('Rendering', fileName)
    const svg = await call(vm, address, abi, 'renderImage', [i])
    await fs.writeFile(fileName, svg)

    // Throws on invalid XML
    new DOMParser().parseFromString(svg)
  }
}

main().catch((error) => {
  console.error(error)
  process.exit(1)
})
