# Executes a command on the robot
# It handles the execution errors of the robot:
# it ensures that the robot does not fall down the table
class CommandExecutor
  attr_reader :robot, :table

  def initialize(robot, table)
    @robot = robot
    @table = table
  end

  def execute(command)
    instruction = command.instruction.downcase
    params = [command.x, command.y, command.direction].compact
    prediction = method('predict_' + instruction).call(*params)

    raise ToyRobot::ExecutionError, '' if execution_error?(*prediction)

    if instruction == 'report'
      puts robot.vector.join(',')
      robot.vector
    else
      robot.vector = *prediction
    end
  end

  private

  def execution_error?(x, y, *_)
    fall_west = x < 0
    fall_east = x > table.width
    fall_south = y < 0
    fall_north = y > table.height

    fall_west || fall_east || fall_south || fall_north
  end

  def predict_place(x, y, direction)
    [x, y, direction]
  end

  def predict_report
    robot.vector
  end

  def predict_move
    x = robot.x
    y = robot.y

    if robot.direction == 'NORTH'
      y += 1
    elsif robot.direction == 'EAST'
      x += 1
    elsif  robot.direction == 'SOUTH'
      y -= 1
    elsif  robot.direction == 'WEST'
      x -= 1
    else
      raise 'Unkown robot direction'
    end

    [x, y, robot.direction]
  end

  # I know that this kind of stuff works:
  # (ordered_array.index('WEST') +1 ) % ordered_array.size
  # But well do you find it simple from KISS?
  def predict_right
    direction = if robot.direction == 'NORTH'
                  'EAST'
                elsif robot.direction == 'EAST'
                  'SOUTH'
                elsif robot.direction == 'SOUTH'
                  'WEST'
                elsif robot.direction == 'WEST'
                  'NORTH'
                else
                  raise 'Unkown robot direction'
                end

    [robot.x, robot.y, direction]
  end

  def predict_left
    direction = if robot.direction == 'NORTH'
                  'WEST'
                elsif robot.direction == 'EAST'
                  'NORTH'
                elsif robot.direction == 'SOUTH'
                  'EAST'
                elsif robot.direction == 'WEST'
                  'SOUTH'
                else
                  raise 'Unkown robot direction'
                end

    [robot.x, robot.y, direction]
  end
end
