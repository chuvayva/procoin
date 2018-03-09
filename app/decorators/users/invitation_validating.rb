class Users::InvitationValidating < SimpleDelegator
  include ActiveModel::Validations

  validates :phone, presence: true, format: /\A8\d{10}\Z/
  validates :name, presence: true

end


