# Represents one command on a commands list file
#
# It checks the command correctness and it's assumed to be  very strict
# syntax parser.
class Command
  class SyntaxError < RuntimeError
  end

  attr_reader :instruction, :x, :y, :direction

  def initialize(*instruction_row)
    @instruction, @x, @y, @direction = instruction_row
    @x = Integer(@x) if @x.present?
    @y = Integer(@y) if @y.present?
  end

  def correct?
    raise SyntaxError, 'Unkown instruction: ' + instruction \
      if !%w[PLACE MOVE LEFT RIGHT REPORT].include? instruction

    public_send(instruction.downcase + '_correct?')

    true
  end

  def move_correct?
    raise SyntaxError, 'Does not understand MOVE with X, Y or DIRECTION' \
      if x.present? || y.present? || direction.present?
  end
  alias_method :right_correct?, :move_correct?
  alias_method :left_correct?, :move_correct?
  alias_method :report_correct?, :move_correct?

  def place_correct?
    raise SyntaxError, 'Unkown direction: ' + direction \
      if !%w[NORTH SOUTH EAST WEST].include? direction

    begin
      @x = Integer(x)
    rescue ArgumentError
      raise SyntaxError, 'Can not cast X: ' + x + ' to integer'
    end

    begin
      @y = Integer(y)
    rescue ArgumentError
      raise SyntaxError, 'Can not cast Y: ' + y + ' to integer'
    end
  end
end
