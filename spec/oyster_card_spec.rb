require 'oyster_card'

describe OysterCard do
  subject(:oyster_card) { described_class.new }

  describe '#balance' do
    it 'has a default balance of 0' do
      expect(oyster_card.balance).to eq OysterCard::DEFAULT_BALANCE
    end
  end
end