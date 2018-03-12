require 'rails_helper'

describe WalletsController do
  login_user

  describe 'POST balance_sync' do
    subject { post :balance_sync, params: { id: current_user.id } }
    let(:current_user) { create :user, wallet: '0xF4e2494252d82DB8776aD0a0edC52f81169C1623' }

    before :each do
      allow(TokenContractService).
        to receive(:balance_of).
        and_return(1)
    end

    it 'should redirect to profile_path' do
      subject

      expect(response).
        to redirect_to profile_path
    end

    it 'set balance' do
      subject

      expect(current_user.reload.balance).
        to eql 1
    end
  end

  describe 'GET new' do
    let(:current_user) { create :user, wallet: nil, balance: 123 }
    subject { get :new }

    it 'set @key' do
      subject

      expect(assigns(:key)).
        to be
    end

    it 'set wallet and 0 balance' do
      subject

      user = assigns(:user)
      expect(user.wallet).
        to be
      expect(user.balance).
        to be 0
    end
  end
end
