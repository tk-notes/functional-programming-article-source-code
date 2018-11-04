PI = 3.14

def calculate_area(radius)
  radius * radius * PI
end

def calculate_area(radius, pi)
  radius * radius * pi
end

class Incrementor
  def initialize(counter)
    @counter = counter
  end

  def call
    @counter = value + 1
    @counter
  end
end

inc = Incrementor.new(counter)
inc.call
