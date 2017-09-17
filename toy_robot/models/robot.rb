# Represent the robot
class Robot
  attr_reader :x, :y, :face

  def initialize(x, y, face)
    place(x, y, face)
  end

  def place(x, y, face)
    @x = x
    @y = y
    @face = face

    [x, y, face]
  end

  def report
    [x, y, face]
  end
end
