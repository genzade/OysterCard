class OysterCard
  DEFAULT_BALANCE = 0
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

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @travelling = true
  end

  def touch_out
    @travelling = false
  end

  def in_journey?
    !!@travelling
  end
end