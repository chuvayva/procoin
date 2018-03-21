class TokenContractService
  ETHEREUM_RPC_URL = ENV.fetch('ETHEREUM_RPC_URL', '')
  ETHEREUM_TOKEN_ADDRESS = ENV.fetch('ETHEREUM_TOKEN_ADDRESS', '')
  ETHEREUM_ADMIN_ACCOUNT = ENV.fetch('ETHEREUM_ADMIN_ACCOUNT', '')
  ETHEREUM_ADMIN_PRIVATE_KEY = ENV.fetch('ETHEREUM_ADMIN_PRIVATE_KEY', '')

  class << self
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
          abi: File.read(Rails.root.join("lib/blockchain/procoin_abi.json")),
          name: 'Procoin',
          address: ETHEREUM_TOKEN_ADDRESS,
          client: rpc_client,
        ).tap { |contract|
          contract.key = Eth::Key.new(priv: ETHEREUM_ADMIN_PRIVATE_KEY)
        }
      end
    end

    def rpc_client
      Ethereum::HttpClient.new(ETHEREUM_RPC_URL).tap do |client|
        client.instance_variable_set :@default_account, ETHEREUM_ADMIN_ACCOUNT
        client.instance_variable_set :@uri, ETHEREUM_RPC_URL
        client.gas_price = 5_000_000_000
      end
    end
  end
end
