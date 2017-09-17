require 'simplecov'
SimpleCov.start

ENV['RUBY_ENV'] = 'test'

require File.expand_path('../../toy_robot.rb', __FILE__)
ToyRobot.new.require_libraries
ToyRobot.new.require_program_files
