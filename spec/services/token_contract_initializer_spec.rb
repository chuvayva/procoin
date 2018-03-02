require 'rails_helper'

describe TokenContractInitializer do

  describe '#init_contract' do
    subject { TokenContractInitializer.init_contract }

    it 'returns contract' do
      class_name = subject.class.name
      expect(class_name).
        to eql 'VitToken'
    end
  end
end
