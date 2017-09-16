# Represents a file where each line is an instruction for the robot
# It's an Enumerable where each object is a robot instruction.
class CommandsList
  include Enumerable

  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def each
    commands.each { |e| yield(e) }
  end

  private

  def commands
    @commands ||= begin
      commands = []
      File.open(file_path, 'r').each_line do |line|
        commands << parse_command(line)
      end
      commands.each
    end
  end

  def parse_command(line)
    instruction, parameters = line.split(' ')
    parameters = parameters.split(',') if parameters.present?
    Command.new(instruction, *parameters)
  end
end
