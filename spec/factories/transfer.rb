require 'factory_bot_rails'

FactoryBot.define do
  factory :transfer do
    status :pending
    signature "0x218f7f9926135523f3cc043deec76debb4f9a4c4021b063ab569bbe4be27b77d13f6455d39f86b4c8e05f3c03c401b841a24056aba7a15a815ee3d36931388f100"
    to "0xf17f52151EbEF6C7334FAD080c5704D77216b732"
    amount 1000
    fee 100
    nonce 221

    association :user
    association :target, factory: :user
  end
end


