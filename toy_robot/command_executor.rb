# Executes a command on the robot
# It handles the execution errors of the robot:
# it ensures that the robot does not fall down the table
class CommandExecutor
  class ExecutionError < RuntimeError
  end

  attr_reader :robot, :table

  def initialize(robot, table)
    @robot = robot
    @table = table
  end

  def execute(command)
    instruction = command.instruction.downcase
    params = [command.x, command.y, command.face].compact
    prediction = method('predict_' + instruction).call(*params)
    raise ExecutionError, '' if execution_error?(*prediction)

    if instruction == 'report'
      puts robot.report.join(',')
      robot.report
    else
      robot.place(*prediction)
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

  def predict_place(x, y, face)
    [x, y, face]
  end

  def predict_report
    robot.report
  end

  def predict_move
    x = robot.x
    y = robot.y

    if robot.face == 'NORTH'
      y += 1
    elsif robot.face == 'EAST'
      x += 1
    elsif  robot.face == 'SOUTH'
      y -= 1
    elsif  robot.face == 'WEST'
      x -= 1
    else
      raise 'Unkown robot direction'
    end

    [x, y, robot.face]
  end

  # I know that this kind of stuff works:
  # (ordered_array.index('WEST') +1 ) % ordered_array.size
  # But well do you find it simple from KISS?
  def predict_right
    face = robot.face

    face = if face == 'NORTH'
             'EAST'
           elsif face == 'EAST'
             'SOUTH'
           elsif  face == 'SOUTH'
             'WEST'
           elsif  face == 'WEST'
             'NORTH'
           else
             raise 'Unkown robot direction'
           end

    [robot.x, robot.y, face]
  end

  def predict_left
    face = robot.face

    face = if face == 'NORTH'
             'WEST'
           elsif face == 'EAST'
             'NORTH'
           elsif  face == 'SOUTH'
             'EAST'
           elsif  face == 'WEST'
             'SOUTH'
           else
             raise 'Unkown robot direction'
           end

    [robot.x, robot.y, face]
  end
end
