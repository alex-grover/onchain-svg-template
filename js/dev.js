import fs from 'node:fs'
import path from 'node:path'
import url from 'node:url';
import serve, { ANIMATION_REGEX, IMAGE_REGEX } from './serve.js';
import boot from './boot.js'
import call from './call.js'
import compile from './compile.js'
import deploy from './deploy.js'

const directory = path.dirname(url.fileURLToPath(import.meta.url))
const SOURCE = path.join(directory, '..', 'src', 'Renderer.sol')

async function main() {
  const { vm, pk } = await boot()

  async function handler(requestUrl) {
    const { abi, bytecode } = compile(SOURCE)
    const address = await deploy(vm, pk, bytecode)

    if (requestUrl === '/collection') {
      return call(vm, address, abi, 'renderCollectionImage')
    } else if (IMAGE_REGEX.test(requestUrl)) {
      const [, id] = IMAGE_REGEX.exec(requestUrl)
      return call(vm, address, abi, 'renderImage', [id])
    } else if (ANIMATION_REGEX.test(requestUrl)) {
      const [, id] = ANIMATION_REGEX.exec(requestUrl)
      return call(vm, address, abi, 'renderAnimation', [id])
    }

    throw new Error(`Unknown URL: ${requestUrl}`)
  }

  const notify = await serve(handler)

  fs.watch(path.dirname(SOURCE), notify)
  console.log('Watching', path.dirname(SOURCE))
  console.log('Serving  http://localhost:9901/')
}

void main()
