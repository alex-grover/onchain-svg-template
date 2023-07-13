import fs from 'node:fs'
import path from 'node:path'
import url from 'node:url';
import serve from './serve.js'
import boot from './boot.js'
import call from './call.js'
import compile from './compile.js'
import deploy from './deploy.js'

const directory = path.dirname(url.fileURLToPath(import.meta.url))
const SOURCE = path.join(directory, '..', 'src', 'Renderer.sol')

async function main() {
  const { vm, pk } = await boot()

  async function handler() {
    const { abi, bytecode } = compile(SOURCE)
    const address = await deploy(vm, pk, bytecode)
    return call(vm, address, abi, 'render', [1])
  }

  const notify = await serve(handler)

  fs.watch(path.dirname(SOURCE), notify)
  console.log('Watching', path.dirname(SOURCE))
  console.log('Serving  http://localhost:9901/')
}

void main()
