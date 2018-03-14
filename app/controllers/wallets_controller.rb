class WalletsController < ApplicationController
  before_action :authenticate_user!

  def new
    if current_user.wallet.blank?
      @user = Users::WalletProcessing.new(current_user)
      @key = @user.generate_and_assign_key
    else
      redirect_to profile_path, alert: 'Пользователь уже имеет кошелек'
    end
  end

  def balance_sync
    if current_user.wallet.present?
      user = Users::WalletProcessing.new(current_user)
      user.balance_sync

      redirect_to profile_path, notice: 'Баланс синхронизирован с блокчейном'
    else
      redirect_to profile_path, alert: 'Сначала надо привязать кошелек'
    end
  end

end
