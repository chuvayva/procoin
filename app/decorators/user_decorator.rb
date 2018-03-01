class UserDecorator < Draper::Decorator
  include WalletHelper
  delegate_all

  def balance_string
    if wallet.present?
      num_with_spaces balance
    else
      "Недоступен"
    end
  end
end
