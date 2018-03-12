require 'rails_helper'

describe TokenContractService do

  describe '.new_transfer' do
    subject { described_class.new_transfer user }
    let(:user) { create :user }

    it { should be_a_kind_of Transfer }

    it 'has nonce' do
      expect(subject.nonce).
        to be > 0
    end
  end

  describe '.block_number' do
    subject { described_class.block_number }
    let(:responce) { {"jsonrpc"=>"2.0", "id"=>1, "result"=>"0x2b0df9"} }

    before do
      allow(described_class).
        to receive(:rpc_client).
        and_return(double(eth_block_number: responce))
    end

    it { should eql 2821625 }
  end
end
