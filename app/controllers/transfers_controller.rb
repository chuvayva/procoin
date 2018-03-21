class TransfersController < ApplicationController
  before_action :authenticate_user!

  def index
    @transfers = current_user.transfers.order(created_at: :desc).preload(:target).decorate
  end

  def new
    scope = current_user.admin? ? User.where.not(id: current_user) : current_user.invitations
    @invitations = scope.order(:name).select(:name, :wallet)
    @transfer = TransferService.prepare_instance current_user
  end

  def create
    transfer = TransferService.new_instance(current_user, transfer_params)

    if transfer.save
      TransferWorker.perform_async transfer.id

      redirect_to transfers_path, notice: 'Ваш перевод принят. Скоро отправим'
    else
      redirect_to transfers_path, alert: 'Что пошло не так! Попробуйте снова или обратитесь к администратору'
    end
  end

  private

  def transfer_params
    params.require(:transfer).permit(
      :to,
      :amount,
      :fee,
      :signature,
      :nonce,
      :token_contract,
      :user_id,
      :from
    )
  end
end
