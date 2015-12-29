require 'oyster_card'

describe OysterCard do
  subject(:oyster_card) { described_class.new }

  let(:card) { described_class.new }

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

  context 'in journey' do
    before do
      oyster_card.top_up(1)
      oyster_card.touch_in
    end

    describe '#touch_in' do
      it 'should be in journey when touched in' do
        expect(oyster_card).to be_in_journey
      end

      it 'should raise an error if balance is not enough' do
        expect { card.touch_in }.to raise_error 'Not Enough Credit: Please Top Up'
      end
    end

    describe '#touch_out' do
      it 'should not be in journey when touched out' do
        oyster_card.touch_out
        expect(oyster_card).not_to be_in_journey
      end

      it 'should deduct a minimum fare upon touching out' do
        minimum_fare = OysterCard::MINIMUM_FARE
        expect { oyster_card.touch_out }.to change { oyster_card.balance }.by(-minimum_fare)
      end
    end
  end
end





