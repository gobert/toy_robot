# Load the program files and the dependencies
# Run the programm
class ToyRobot
  def self.environment
    @environment = (ENV['RUBY_ENV'] || ENV['ENV'] || ENV['RACK_ENV'] ||
                    ENV['RAILS_ENV'] || :development).to_sym
  end

  def self.logger
    @logger ||= begin
      log_on = if environment == :development
                 STDOUT
               else
                 "log/#{environment}.log"
               end
      logger = Logger.new(log_on)
      logger.level = Logger::INFO
      logger
    end
  end

  def delegate
    Board.new.foo
  end

  def root
    __FILE__
  end

  def require_libraries
    require 'logger'
    require 'bundler'
    require 'active_support/core_ext/object/blank'
    Bundler.require(self.class.environment)
  end

  def require_program_files
    require File.expand_path('../models/table.rb', root)
    require File.expand_path('../models/command.rb', root)
    require File.expand_path('../models/commands_list.rb', root)
    require File.expand_path('../command_executor.rb', root)
    require File.expand_path('../errors.rb', root)
    require File.expand_path('../runner.rb', root)
    require File.expand_path('../models/robot.rb', root)
  end
end
