require 'rails_helper'

describe TransferWorker do

  describe '#perform' do
    subject { described_class.new.perform(transfer.id) }
    let(:transfer) { create :transfer }
    let(:tx) { double id: '0xe453ae4806cbd9d69561a30957688f375b0e84ae5e135018157cab3514a90cba' }
    let(:contract) { double('key=': nil, transact_and_wait: double(transfer_pre_signed: tx)) }
    let(:success_receipt) { { 'result' => { 'status' => '0x1' } } }

    before do
      allow(TokenContractService).
        to receive_message_chain(:token_contract).
        and_return(contract)
      allow_any_instance_of(Ethereum::HttpClient).
        to receive(:eth_get_transaction_receipt).
        and_return(success_receipt)
    end

    it 'set status complete' do
      subject

      expect(transfer.reload.status).
        to eql 'completed'
      expect(transfer.tx).
        to eql tx.id
    end
  end
end

