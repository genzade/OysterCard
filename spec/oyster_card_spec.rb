require 'oyster_card'

describe OysterCard do
  subject(:oyster_card) { described_class.new }

  describe 'initialization' do
    describe '#balance' do
      it 'has a default balance of 0' do
        expect(oyster_card.balance).to eq OysterCard::DEFAULT_BALANCE
      end
    end

    describe '#travelling' do
      it 'is initially not in a journey' do
        expect(oyster_card).not_to be_in_journey
      end
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

  describe '#deduct' do
    it 'deducts amount from the oyster card' do
      maximum_balance = OysterCard::LIMIT
      oyster_card.top_up(maximum_balance)
      expect { oyster_card.deduct(2) }.to change { oyster_card.balance }.by -2
    end
  end

  context 'in journey' do
    before do
      oyster_card.top_up(20)
      oyster_card.touch_in
    end

    describe '#touch_in' do
      it "should be in journey when touched in" do
        expect(oyster_card).to be_in_journey
      end
    end

    describe '#touch_out' do
      it 'not be in journey when touched out' do
        oyster_card.touch_out
        expect(oyster_card).not_to be_in_journey
      end
    end
  end
end





