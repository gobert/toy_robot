# Represent the tabletop where the robot is moving
class Table
  attr_reader :width, :height

  def initialize(width, height)
    @width = width
    @height = height
  end
end
