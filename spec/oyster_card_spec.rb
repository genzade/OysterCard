require 'oyster_card'

describe OysterCard do
  subject(:oyster_card) { described_class.new }

  let(:card) { described_class.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  let(:journey) { {:entry_station=>entry_station, :exit_station=>exit_station} }

  default_balance = OysterCard::DEFAULT_BALANCE
  maximum_balance = OysterCard::LIMIT
  minimum_fare = OysterCard::MINIMUM_FARE

  describe 'initialization' do
    describe '#balance' do
      it 'has a default balance of 0' do
        expect(oyster_card.balance).to eq default_balance
      end
    end

    describe '#in_journey' do
      it 'is initially not in a journey' do
        expect(oyster_card).not_to be_in_journey
      end
    end

    describe '#journey' do
      it 'journey should be empty to begin with' do
        expect(oyster_card.journey).to be_empty
      end
    end

    describe '#journeys' do
      it 'journey history should be empty to begin with' do
        expect(oyster_card.journeys).to be_empty
      end
    end
  end

  describe '#top_up' do
    it 'can top up balance' do
      expect { oyster_card.top_up(1) }.to change { oyster_card.balance }.by 1
    end

    it 'cannot top up beyond the maximum limit' do
      oyster_card.top_up(maximum_balance)
      expect { oyster_card.top_up(1) }.to raise_error "Maximum Limit: £#{maximum_balance}"
    end
  end

  context 'when in journey' do
    before do
      oyster_card.top_up(1)
      oyster_card.touch_in(entry_station)
    end

    describe '#touch_in(entry_station)' do
      it 'should be in journey when touched in' do
        expect(oyster_card).to be_in_journey
      end

      it 'should raise an error if balance is not enough' do
        expect { card.touch_in(entry_station) }.to raise_error 'Not Enough Credit: Please Top Up'
      end

      it 'records entry station upon touching in' do
        expect(oyster_card.journey).to eq :entry_station=>entry_station
      end
    end

    describe '#touch_out(station)' do
      it 'should deduct a minimum fare upon touching out' do
        expect { oyster_card.touch_out(exit_station) }.to change { oyster_card.balance }.by(-minimum_fare)
      end

      it 'should not be in journey when touched out' do
        oyster_card.touch_out(exit_station)
        expect(oyster_card).not_to be_in_journey
      end

      it 'resets the entry station upon touching out' do
        oyster_card.touch_out(exit_station)
        expect(oyster_card.entry_station).to be_nil
      end

      it 'stores exit station' do
        oyster_card.touch_out(exit_station)
        expect(oyster_card.exit_station).to eq exit_station
      end

      it 'stores a journey' do
        oyster_card.touch_out(exit_station)
        expect(oyster_card.journeys).to include journey
      end
    end
  end
end




