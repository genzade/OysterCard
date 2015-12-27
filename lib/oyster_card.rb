class OysterCard
  DEFAULT_BALANCE = 0
  LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = DEFAULT_BALANCE
  end

  def top_up(amount)
    @balance += amount
    raise 'Maximum Limit: £90' if @balance > LIMIT
  end
end