class OysterCard
  DEFAULT_BALANCE = 0
  MINIMUM_FARE = 1
  LIMIT = 90

  attr_reader :balance, :card_active, :journey, :journeys

  def initialize
    @balance = DEFAULT_BALANCE
    @card_active = false
    @journey = {}
    @journeys = []
  end

  def top_up(amount)
    raise 'Maximum Limit: £90' if amount + balance > LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise 'Not Enough Credit: Please Top Up' if balance < MINIMUM_FARE
    @card_active = true
    @journey[:entry] = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey[:exit] = station
    record_journey
    @card_active = false
  end

  def in_journey?
    !!@card_active
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def record_journey
    @journeys << @journey
  end
end