require 'rails_helper'

describe Users::InvitationValidating do
  let(:user) { create :user }
  let(:decorated) { described_class.new(user) }

  describe '#valid?' do
    subject { decorated.valid? }
    context 'duplicated phone' do
      let!(:user_2) { create :user, phone: '89270001234' }
      let(:user) { build :user, phone: user_2.phone }

      it { should be false }
    end
  end
end

