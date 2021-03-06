class Journey
  MINIMUM_FARE = 1
  PENALTY = 6

  attr_reader :journey_current, :journeys

  def initialize
    @journeys = []
    @journey_current = {}
  end

  def touch_in(station)
    if in_journey?
      record_journey
    end
    @journey_current[:entry] = station
  end

  def touch_out(station)
    @journey_current[:exit] = station
    record_journey
  end

  def in_journey?
    @journey_current.length == 1
  end

  def fare
    total = 0
    unless @journeys.empty?
      total += PENALTY + MINIMUM_FARE if journeys[-1][:exit] == nil
      total += PENALTY if journeys[-1][:entry] == nil
    end
    total += MINIMUM_FARE if journey_current.empty?
    return total
  end

  def min_fare
    MINIMUM_FARE
  end

  private

  def record_journey
    @journeys << @journey_current
    @journey_current = {}
  end
end