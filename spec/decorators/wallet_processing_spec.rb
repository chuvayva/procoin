require 'rails_helper'

describe Users::WalletProcessing do
  let(:user) { create :user }
  subject { described_class.new(user) }

  describe '#balance_sync' do
    let(:user) { create :user, wallet: '0x3702996923eba1b7c50b9748ca46b19bc56a41d0' }
    subject do
      VCR.use_cassette "wallet_proccessing/balance_sync" do
        described_class.new(user).balance_sync
      end
    end

    it 'should change balance' do
      expect { subject }.
        to change { user.reload.balance }
    end


  end
end
