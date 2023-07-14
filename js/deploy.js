import ethereumjsTx from '@ethereumjs/tx'
import { Address } from 'ethereumjs-util'
const { Transaction } = ethereumjsTx

export default async function deploy(vm, pk, bytecode) {
  const address = Address.fromPrivateKey(pk)
  const account = await vm.stateManager.getAccount(address)

  const txData = {
    value: 0,
    gasLimit: 200_000_000_000,
    gasPrice: 1,
    data: '0x' + bytecode.toString('hex'),
    nonce: account.nonce,
  }

  const tx = Transaction.fromTxData(txData).sign(pk)

  const deploymentResult = await vm.runTx({ tx })

  if (deploymentResult.execResult.exceptionError) {
    throw deploymentResult.execResult.exceptionError
  }

  return deploymentResult.createdAddress
}
