require 'rails_helper'

describe TransfersController do
  login_user

  describe 'GET new' do
    subject { get :new }
    let(:current_user) { create :user, :with_invitations }

    context 'render_views' do
      render_views

      it 'renders the new template' do
        subject
        expect(response).
          to render_template('new')
      end
    end

    it 'should set variables' do
      subject

      expect(assigns(:invitations)).to be
      expect(assigns(:transfer)).to be
    end
  end

  describe 'POST create' do
    subject { post :create, params: transfer_params }
    let(:target) { create :user, wallet: "0x7037D59CFAed188B08596A103717e0F53C4c926e" }

    let(:transfer_params) {
      {
        transfer: {
          user_id: current_user.id,
          from: "0x3702996923eBA1b7C50B9748Ca46B19bC56A41D0",
          nonce: 877,
          token_contract: "0xa85dc908f32bd58c4c4b25f90b843d5fd971df0e",
          to: target.wallet,
          amount: 12414,
          fee: 100,
          signature: "your signature"
        }
      }
    }

    it 'create new transaction' do
      expect { subject }.
        to change(Transfer, :count)
    end

    it 'set sidekiq job' do
      expect(TransferWorker).
        to receive(:perform_async)

      subject
    end
  end
end
