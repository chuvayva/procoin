require 'rails_helper'

describe TransferService do

  describe '.prepare_instance' do
    subject { described_class.prepare_instance user }
    let(:user) { create :user }

    it { should be_a_kind_of Transfer }

    it 'has nonce' do
      expect(subject.nonce).
        to be > 0
    end
  end

end
