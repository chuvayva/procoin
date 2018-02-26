class User < ApplicationRecord

  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable,
    :validatable, :registerable, :confirmable

  validates :name, presence: true
  validates :wallet, format: /\A0x[a-fA-F0-9]{40}\Z/, if: 'wallet.present?'

end
