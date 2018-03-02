require 'rails_helper'

describe UsersController do
  login_user

  describe 'POST balance_sync (integration test)' do
    subject { post :balance_sync, params: { id: current_user.id } }
    let(:current_user) { create :user, wallet: '0xF4e2494252d82DB8776aD0a0edC52f81169C1623' }
    let(:contract) { double call: double(balance_of: 1) }

    before :each do
      allow_any_instance_of(Users::WalletProcessing).
        to receive(:token_contract).
        and_return(contract)
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
end
