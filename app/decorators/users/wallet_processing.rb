module Users
  class WalletProcessing < SimpleDelegator
    cattr_accessor :token_contract

    def balance_sync
      balance = token_contract.call.balance_of(wallet)
      update_attributes(balance: balance)
    end
  end
end
