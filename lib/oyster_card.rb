class OysterCard
  DEFAULT_BALANCE = 0
  MINIMUM_FARE = 1
  LIMIT = 90

  attr_reader :balance, :entry_station

  def initialize
    @balance = DEFAULT_BALANCE
    @entry_station = nil
  end

  def top_up(amount)
    raise 'Maximum Limit: £90' if amount + balance > LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise 'Not Enough Credit: Please Top Up' if balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end