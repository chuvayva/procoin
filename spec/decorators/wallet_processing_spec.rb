require 'rails_helper'

describe Users::WalletProcessing do
  let(:user) { create :user }
  let(:decorated) { described_class.new(user) }

  describe '#balance_sync' do
    let(:user) { create :user, wallet: '0x3702996923eba1b7c50b9748ca46b19bc56a41d0' }
    subject do
      VCR.use_cassette "wallet_proccessing/balance_sync" do
        decorated.balance_sync
      end
    end

    it 'should change balance' do
      expect { subject }.
        to change { user.reload.balance }
    end
  end

  describe '#generate_and_assign_key' do
    subject { decorated.generate_and_assign_key }

    it 'returns a key' do
      expect(subject).
        to be_a_kind_of(Eth::Key)
    end

    it 'assign new wallet address to user' do
      key = subject

      expect(user.wallet).
        to eql key.address
      expect(user.balance).
        to eql 0
    end
  end
end
