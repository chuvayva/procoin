module TokenContractInitializer
  ETHEREUM_RPC_URL = ENV.fetch('ETHEREUM_RPC_URL', '')
  ETHEREUM_TOKEN_ADDRESS = ENV.fetch('ETHEREUM_TOKEN_ADDRESS', '')
  ETHEREUM_ADMIN_ACCOUNT = ENV.fetch('ETHEREUM_ADMIN_ACCOUNT', '')

  class << self
    def init_contract
      Ethereum::Contract.create(
        abi: File.read(Rails.root.join("lib/blockchain/vit_token_abi.json")),
        name: 'VitToken',
        address: ETHEREUM_TOKEN_ADDRESS,
        client: rpc_client,
      )
    end

    def rpc_client
      Ethereum::HttpClient.new(ETHEREUM_RPC_URL).tap do |client|
        client.instance_variable_set :@default_account, ETHEREUM_ADMIN_ACCOUNT
        client.instance_variable_set :@uri, ETHEREUM_RPC_URL
      end
    end
  end
end
