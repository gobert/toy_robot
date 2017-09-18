#! /usr/bin/env ruby
require File.expand_path('../../toy_robot/toy_robot.rb', __FILE__)
ToyRobot.new.require_libraries
ToyRobot.new.require_program_files

puts ''
puts 'ToyRobot loaded'
puts 'Starting ...'
puts ''

if ARGV.length != 1
  puts 'Missing commands list file'
  puts 'Usage:'
  puts '  ruby bin/toy_robot.rb spec/fixtures/valid_command_list'

  exit(1)
else
  Runner.new(ARGV[0]).run
end
