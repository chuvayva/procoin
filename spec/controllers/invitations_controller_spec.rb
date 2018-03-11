require 'rails_helper'

describe InvitationsController do
  login_user

  describe 'POST create' do
    subject { post :create, params: { user: user_params } }

    context 'valid attributes' do
      let(:user_params) { attributes_for :user, name: 'Michael', phone: '89270001234' }

      it 'creates a new user' do
        expect { subject }.
          to change { User.count }
      end

      it 'set new user with raw_invite_token' do
        subject

        user = assigns(:user)
        expect(user.raw_invitation_token).
          to be
      end

      it 'render success_invite' do
        expect(subject).
          to render_template(:success_invite)
      end
    end

    context 'invalid attributes' do
      let(:user_params) { attributes_for :user, name: nil, phone: '89270001234' }

      it 'does not a create new user' do
        expect { subject }.
          not_to change { User.count }
      end

      it 'set new user with raw_invite_token' do
        subject

        user = assigns(:user)
        expect(user.raw_invitation_token).
          not_to be
      end

      it 'render new again' do
        expect(subject).
          to render_template(:new)
      end
    end
  end
end

