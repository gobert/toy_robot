# Runs the programm
# This glue all parts of the application together
# - delegates parsing to CommandsList: it delegates " read the input file"
# - delegates excution to CommandExecutor (for each command)
class Runner
  attr_reader :commands_list_paths

  def initialize(commands_list_paths)
    @commands_list_paths = commands_list_paths
  end

  def run
    commands_list.each do |command|
      begin
        executor.execute(command)
      rescue ToyRobot::ExecutionError
        # sic.
        message = "#{command.inspect} for robot #{robot.inspect}"
        ToyRobot.logger.warn message
      end
    end
  end

  private

  def executor
    @executor ||= CommandExecutor.new(robot, table)
  end

  def robot
    @robot ||= Robot.new(0, 0, 'NORTH')
  end

  def table
    @table ||= Table.new(5, 5)
  end

  def commands_list
    @commands_list ||= CommandsList.new(commands_list_paths)
  end
end
