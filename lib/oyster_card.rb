class OysterCard
  DEFAULT_BALANCE = 0
  MINIMUM_FARE = 1
  LIMIT = 90

  attr_reader :balance, :travelling

  def initialize
    @balance = DEFAULT_BALANCE
    @travelling = false
  end

  def top_up(amount)
    raise 'Maximum Limit: £90' if amount + balance > LIMIT
    @balance += amount
  end

  def touch_in
    raise 'Not Enough Credit: Please Top Up' if balance < MINIMUM_FARE
    @travelling = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @travelling = false
  end

  def in_journey?
    !!@travelling
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end