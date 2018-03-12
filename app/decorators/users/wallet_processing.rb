module Users
  class WalletProcessing < SimpleDelegator

    def generate_and_assign_key
      Eth::Key.new.tap do |key|
        assign_attributes(
          wallet: key.address,
          balance: 0
        )
      end
    end

    def balance_sync
      return nil if wallet.blank?

      balance = TokenContractService.balance_of(wallet)
      update_attributes(balance: balance)
    end
  end
end
