require 'journey'

describe Journey do
  subject(:journey) { described_class.new }

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe '#in_journey' do
      it 'is initially not in a journey' do
        expect(journey).not_to be_in_journey
      end
    end

    describe '#journey' do
      it 'journey should be empty to begin with' do
        expect(journey.journey_current).to be_empty
      end
    end

    describe '#journeys' do
      it 'journey history should be empty to begin with' do
        expect(journey.journeys).to be_empty
      end
    end

    context 'storing jounreys' do
      before do
        journey.touch_in(entry_station)
      end
      describe '#touch_in(entry_station)' do
        it 'should be in journey when touched in' do
          expect(journey).to be_in_journey
        end

        it 'records entry station upon touching in' do
          expect(journey.journey_current).to eq :entry=>entry_station
        end
      end

      describe '#touch_out(station)' do
        it 'should not be in journey when touched out' do
          journey.touch_out(exit_station)
          expect(journey).not_to be_in_journey
        end

        it 'stores a journey' do
          journey.touch_out(exit_station)
          expect(journey.journeys).to include journey.journeys.first
        end
      end
    end

    describe '#fare' do
      it 'should charge penalty fare if user does not touch in' do
        journey.touch_out(exit_station)
        expect(journey.penalty_fare).to eq(7)
      end

      it 'should charge penalty fare if user does not touch out' do
        journey.touch_in(entry_station)
        journey.touch_in(entry_station)
        expect(journey.penalty_fare).to eq(7)
      end

      it 'should charge minimum fare if user completes journey' do
        journey.touch_in(entry_station)
        journey.touch_out(exit_station)
        expect(journey.penalty_fare).to eq(1)
      end
    end
end