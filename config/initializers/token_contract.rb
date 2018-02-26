ETHEREUM_RPC_URL = ENV.fetch('ETHEREUM_RPC_URL', '')
ETHEREUM_TOKEN_ADDRESS = ENV.fetch('ETHEREUM_TOKEN_ADDRESS', '')
ETHEREUM_ADMIN_ACCOUNT = ENV.fetch('ETHEREUM_ADMIN_ACCOUNT', '')


client = Ethereum::HttpClient.new(ETHEREUM_RPC_URL)
client.instance_variable_set :@default_account, ETHEREUM_ADMIN_ACCOUNT
client.instance_variable_set :@uri, ETHEREUM_RPC_URL

contract = Ethereum::Contract.create(
  file: Rails.root.join("lib/blockchain/VitToken.sol"),
  address: ETHEREUM_TOKEN_ADDRESS,
  client: client,
  contract_index: 1
)

Users::WalletProcessing.token_contract = contract
