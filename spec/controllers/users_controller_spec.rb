require 'rails_helper'

describe UsersController do
  login_user

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
