require 'factory_bot_rails'

FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "#{Faker::Internet.email}_#{n}" }
    sequence(:name) {|n| "#{Faker::StarWars.character} №#{n}" }
    password  '123456'
  end
end

