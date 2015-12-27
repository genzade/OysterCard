require 'oyster_card'

describe OysterCard do
  subject(:oyster_card) { described_class.new }

  describe '#balance' do
    it 'has a default balance of 0' do
      expect(oyster_card.balance).to eq OysterCard::DEFAULT_BALANCE
    end
  end

  describe '#top_up' do
    it 'can top up balance' do
      expect {oyster_card.top_up(1) }.to change { oyster_card.balance }.by 1
    end

    it 'cannot top up beyond the maximum limit' do
      maximum_balance = OysterCard::LIMIT
      oyster_card.top_up(maximum_balance)
      expect { oyster_card.top_up(1) }.to raise_error "Maximum Limit: £#{maximum_balance}"
    end
  end
end