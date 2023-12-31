import { defaultAbiCoder, Interface } from '@ethersproject/abi'

export default async function call(vm, address, abi, name, args = []) {
  const iface = new Interface(abi)
  const data = iface.encodeFunctionData(name, args)

  const renderResult = await vm.runCall({
    to: address,
    caller: address,
    origin: address,
    data: Buffer.from(data.slice(2), 'hex'),
  })

  if (renderResult.execResult.exceptionError) {
    throw renderResult.execResult.exceptionError
  }

  const logs = renderResult.execResult.logs?.map(([, , data]) =>
    data.toString().replace(/\x00/g, '')
  )

  if (logs?.length) {
    console.log(logs)
  }

  const results = defaultAbiCoder.decode(
    ['string'],
    renderResult.execResult.returnValue
  )

  return results[0]
}
