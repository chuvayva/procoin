class TransferWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default

  def perform(transfer_id)
    transfer = Transfer.find(transfer_id)

    return unless transfer.pending?

    begin
      contract = TokenContractService.token_contract
      tx = contract.transact_and_wait.transfer_pre_signed(
        Eth::Utils.hex_to_bin(transfer.signature),
        transfer.to,
        transfer.amount,
        transfer.fee,
        transfer.nonce
      )

      rpc_client = TokenContractService.rpc_client
      receipt = rpc_client.eth_get_transaction_receipt(tx.id)
      status = (receipt.dig("result", "status") == "0x1") ? :completed
                                                          : :failed

      transfer.update_attributes(status: status, tx: tx.id)
    rescue => e
      puts e
      transfer.update_attributes(status: :error)
    end
  end
end
