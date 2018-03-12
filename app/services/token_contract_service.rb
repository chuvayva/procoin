class TokenContractService
  ETHEREUM_RPC_URL = ENV.fetch('ETHEREUM_RPC_URL', '')
  ETHEREUM_TOKEN_ADDRESS = ENV.fetch('ETHEREUM_TOKEN_ADDRESS', '')
  ETHEREUM_ADMIN_ACCOUNT = ENV.fetch('ETHEREUM_ADMIN_ACCOUNT', '')
  ETHEREUM_TOKEN_TRANSFER_FEE = ENV.fetch('ETHEREUM_TOKEN_TRANSFER_FEE', 0)

  class << self
    def new_transfer(user)
      Transfer.new.tap do |t|
        t.nonce = rand(1000)
        t.fee = ETHEREUM_TOKEN_TRANSFER_FEE
        t.user = user
        t.from = user.wallet
        t.token_contract = ETHEREUM_TOKEN_ADDRESS
      end
    end

    def balance_of(address)
      token_contract.call.balance_of(address)
    end

    def block_number
      result = rpc_client.eth_block_number
      result["result"].to_i(16)
    end

    def token_contract
      @_token_contract ||= begin
        Ethereum::Contract.create(
          abi: File.read(Rails.root.join("lib/blockchain/vit_token_abi.json")),
          name: 'VitToken',
          address: ETHEREUM_TOKEN_ADDRESS,
          client: rpc_client,
        )
      end
    end

    def rpc_client
      Ethereum::HttpClient.new(ETHEREUM_RPC_URL).tap do |client|
        client.instance_variable_set :@default_account, ETHEREUM_ADMIN_ACCOUNT
        client.instance_variable_set :@uri, ETHEREUM_RPC_URL
      end
    end
  end
end
