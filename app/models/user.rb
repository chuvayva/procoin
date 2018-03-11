class User < ApplicationRecord

  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable,
    :validatable

  validates :name, presence: true
  validates :wallet, format: /\A0x[a-fA-F0-9]{40}\Z/, if: 'wallet.present?'
  validates :phone, uniqueness: true, format: /\A8\d{10}\Z/, if: 'phone.present?'

  has_many :invitations, class_name: self.to_s, as: :invited_by

end
