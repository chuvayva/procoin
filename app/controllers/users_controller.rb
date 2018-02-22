class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      redirect_to :profile, notice: 'Пользователь успешно изменен'
    else
      render :profile
    end
  end

  def new_wallet
    if current_user.wallet.blank?
      @key = Eth::Key.new
      current_user.wallet = @key.address
    else
      redirect_to profile_path, notice: 'Пользователь уже имеет кошелек'
    end
  end

  private

  def user_params
    params.require(:user).permit(:wallet)
  end
end
