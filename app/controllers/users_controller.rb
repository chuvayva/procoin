class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = current_user.decorate
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to :profile, notice: 'Пользователь успешно изменен'
    else
      render :edit, notice: 'Что-то пошло не так'
    end
  end

  def new_wallet
    if current_user.wallet.blank?
      user = Users::WalletProcessing.new(current_user)
      @key = user.generate_and_assign_key
    else
      redirect_to profile_path, notice: 'Пользователь уже имеет кошелек'
    end
  end

  def balance_sync
    if current_user.wallet.present?
      user = Users::WalletProcessing.new(current_user)
      user.balance_sync

      redirect_to profile_path, notice: 'Баланс синхронизирован с блокчейном'
    else
      redirect_to profile_path, notice: 'Сначала надо привязать кошелек'
    end
  end

  private

  def user_params
    params.require(:user).permit(:wallet, :phone, :name)
  end
end
