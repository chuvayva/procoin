module TransferService
  ETHEREUM_TOKEN_TRANSFER_FEE = ENV.fetch('ETHEREUM_TOKEN_TRANSFER_FEE', 0)
  ETHEREUM_TOKEN_ADDRESS = ENV.fetch('ETHEREUM_TOKEN_ADDRESS', '')

  class << self
    def prepare_instance(user)
      Transfer.new.tap do |t|
        t.nonce = rand(1000)
        t.fee = ETHEREUM_TOKEN_TRANSFER_FEE
        t.user = user
        t.from = user.wallet
        t.token_contract = ETHEREUM_TOKEN_ADDRESS
      end
    end

    def new_instance(user, params)
      return Transfer.new if params[:fee] != ETHEREUM_TOKEN_TRANSFER_FEE

      target_user = User.find_by_wallet params[:to]
      attributes = params.merge(user: user, from: user.wallet, target: target_user)

      Transfer.new attributes
    end


  end
end
