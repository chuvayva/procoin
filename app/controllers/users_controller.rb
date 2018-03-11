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
      render :edit
    end
  end

  def reset_invitation_token
    @user = User.find(params[:user_id])
    @user.send(:generate_invitation_token)
    @user.save
    @user = @user.decorate

    render 'invitations/success_invite'
  end

  private

  def user_params
    params.require(:user).permit(:wallet, :phone, :name, :balance)
  end
end
