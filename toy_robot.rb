# Load the program files and the dependencies
# Run the programm
class ToyRobot
  attr_reader :environment

  def initialize
    @environment = (ENV['RUBY_ENV'] || ENV['ENV'] || ENV['RACK_ENV'] ||
                    ENV['RAILS_ENV'] || :development).to_sym
  end

  def delegate
    Board.new.foo
  end

  def root
    __FILE__
  end

  def require_libraries
    require 'bundler'
    require 'active_support/core_ext/object/blank'
    Bundler.require(environment)
  end

  def require_program_files
    require File.expand_path('../command.rb', root)
    require File.expand_path('../commands_list.rb', root)
  end
end
