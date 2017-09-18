# Represent the robot by a vector (x, y, direction)
# It is not responsible for executing the commands MOVE RIGHT LEFT. Those
# commands depends not only of the robot but of the context (table, ...) so
# they will be implemented in another class.
class Robot
  attr_reader :x, :y, :direction
  attr_accessor :placed

  def initialize
    self.placed = false
  end

  def vector=(*args)
    @x, @y, @direction = args.flatten
    args.flatten
  end

  def vector
    [x, y, direction]
  end
end
