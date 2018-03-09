class InvitationsController < ApplicationController
  def index
    @accepted_invitations = current_user.invitations.invitation_accepted
    @not_accepted_invitations = current_user.invitations.invitation_not_accepted
  end

  def new
    @user = User.new
  end

  def create
    email = "#{user_params[:phone]}_invited_by_#{current_user.email}"
    new_user_params = user_params.merge(email: email, invitation_sent_at: Time.now.utc, skip_invitation: true)
    @user = User.new new_user_params
    @user = Users::InvitationValidating.new(@user)

    if @user.valid?
      @user.invite!(current_user)
      @user = @user.decorate

      render :success_invite
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:phone, :name)
  end
end
