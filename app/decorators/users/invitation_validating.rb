class Users::InvitationValidating < SimpleDelegator
  include ActiveModel::Validations

  validates :phone, format: /\A8\d{10}\Z/
  validates :name, presence: true

  validate :phone_uniqueness

  def phone_uniqueness
    errors.add(:phone, :taken) if User.where.not(id: id).where(phone: phone).exists?
  end
end


