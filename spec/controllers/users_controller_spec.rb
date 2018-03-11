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

  describe 'PUT update' do
    let(:current_user) { create :user, name: 'Alex'}
    let(:user_attrs) { attributes_for :user, name: 'Vit' }
    subject { put :update, params: { id: current_user.id, user: user_attrs } }

    it 'should change name' do
      subject
      expect(current_user.reload.name).
        to eql user_attrs[:name]
    end
  end

  describe 'GET new_wallet' do
    let(:current_user) { create :user, wallet: nil, balance: 123 }
    subject { get :new_wallet }

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

  describe 'PATCH reset_invitation_token' do
    let(:current_user) { create :user, wallet: nil, balance: 123 }
    subject { patch :reset_invitation_token, params: { user_id: current_user.id } }

    it 'assign user with raw_invitation_token' do
      subject

      user = assigns(:user)
      expect(user.raw_invitation_token).
        to be
    end
  end
end
