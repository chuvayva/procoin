class User < ApplicationRecord

  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable,
    :validatable, :registerable, :confirmable

  validates :name, presence: true

end
