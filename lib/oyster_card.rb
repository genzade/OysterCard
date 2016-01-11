require_relative 'journey'

class OysterCard
  DEFAULT_BALANCE = 0
  MINIMUM_FARE = 1
  LIMIT = 90

  attr_reader :balance

  def initialize(journey = Journey.new)
    self.balance = DEFAULT_BALANCE
    @journey = journey
  end

  def top_up(amount)
    raise 'Maximum Limit: £90' if amount + balance > LIMIT
    self.balance += amount
  end

  def touch_in(station)
    raise 'Not Enough Credit: Please Top Up' if balance < MINIMUM_FARE
    @journey.touch_in(station)
  end

  def touch_out(station)
    @journey.touch_out(station)
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @journey.in_journey?
  end

  private

  def balance=(amount)
    @balance = amount if amount.is_a?(Fixnum)
  end

  def deduct(amount)
    self.balance -= amount
  end
end