class Station
  CENTRAL = {
    Bank: 1, 
    Liverpool_Street:   1,
    Bethnal_Green:      2,
    Mile_End:           2,
    Stratford:          3,
    Leyton:             3,
    Leytonstone:        3,
    Snaresbrook:        4,
    South_Woodford:     4,
    Woodford:           4,
    Buckhurst_Hill:     5
  }
  
  attr_reader :name, :zone

  def initialize name
    @name = name
    @zone = CENTRAL[name]
  end
end