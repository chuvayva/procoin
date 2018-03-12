class TransfersController < ApplicationController

  def new
    @transfer = TokenContractService.new_transfer current_user
  end

  def create
    target_user = User.find_by_wallet transfer_params[:to]
    attributes = transfer_params.merge(user: current_user, from: current_user.wallet, target: target_user)
    transfer = Transfer.new attributes

    if transfer.save
      redirect_to transfers_path, notice: 'Ваш перевод принят к отправке. Скоро мы передадим его в блокчейн'
    else
      redirect_to transfers_path, notice: 'Что пошло не так! Попробуйте снова или обратитесь к администратору'
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
