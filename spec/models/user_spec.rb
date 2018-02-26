require 'rails_helper'

describe User do
  let(:user) { create :user }
  subject { user }

  it { should be_present }

  describe 'validation' do
    subject { user.save }
    describe 'wallet' do
      context 'when nil' do
        let(:user) { build :user, wallet: nil }
        it { should be true }
      end

      context 'when invalid wallet' do
        let(:user) { build :user, wallet: 'invalid address' }
        it { should be false }
      end

      context 'when valid wallet' do
        let(:user) { build :user, wallet: '0xF4e2494252d82DB8776aD0a0edC52f81169C1623' }
        it { should be true }
      end
    end
  end
end
