class UserDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
  include WalletHelper
  delegate_all

  HOST = ENV.fetch("HOST", nil)

  def balance_string
    if wallet.present?
      num_with_spaces balance
    else
      "Недоступен"
    end
  end

  def invitation_url
    accept_user_invitation_url(host: HOST, invitation_token: raw_invitation_token)
  end
end
