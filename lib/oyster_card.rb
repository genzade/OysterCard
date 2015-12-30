class OysterCard
  DEFAULT_BALANCE = 0
  MINIMUM_FARE = 1
  LIMIT = 90

  attr_reader :balance, :entry_station, :exit_station, :journey, :journeys

  def initialize
    @balance = DEFAULT_BALANCE
    @entry_station = nil
    @journey = {}
    @journeys = []
  end

  def top_up(amount)
    raise 'Maximum Limit: £90' if amount + balance > LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise 'Not Enough Credit: Please Top Up' if balance < MINIMUM_FARE
    @entry_station = station
    @journey[:entry_station] = @entry_station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @exit_station = station
    @journey[:exit_station] = @exit_station
    record_journey
  end

  def in_journey?
    !!@entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def record_journey
    @journeys << @journey
  end
end