# Toy Robot Simulator
[![Travis build information for branch master](https://api.travis-ci.org/gobert/toy_robot.svg?branch=master)](https://travis-ci.org/gobert/toy_robot)
[![Code Climate](https://codeclimate.com/github/gobert/toy_robot/badges/gpa.svg)](https://codeclimate.com/github/gobert/toy_robot)
[![Dependency Status](https://gemnasium.com/gobert/toy_robot.svg)](https://gemnasium.com/gobert/toy_robot)
[![Security warnings](https://hakiri.io/github/gobert/toy_robot/master.svg)](https://hakiri.io/projects/b8d0f5e3ca8785)

This is a simulator of a robot that evolve on a 5x5 square tabletop. As input it takes a file like:

```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```
The ```REPORT``` command will announce the X,Y and F of the robot: it will be our output on STDOUT.

# Set up
* Install ruby 2.4.1. For instance using rvm: ``` rvm install 2.4.1```
* Install gem bundler: ```gem install bundler --no-ri --no-rdoc```
* Install dependencies: ```bundle install```

# Run it
Run it with the following:
```
ENV=production bundle exec ruby bin/toy_robot.rb spec/fixtures/valid_command_list
```
There is a ```bin/``` folder. So if you want to install the application on your computer, you can add it to your UNIX's variable "$PATH".

# Test suite
On top of each commit, all tests must pass:
```
  bundle exec rspec -- spec/
```
# Check code syntax
On top of each commit, no offenses must be detected
```
  bundle exec rubocop -c .rubocop-validation.yml -- .
```
This will check the core offenses. The other "offenses" are related to the code quality. They are handled in ```.rubocop.yml```: so advices are displayed in the IDE, but they don't block the deployment.

# Conceptualization of the problem
This kind of problem is a translation / compilator (yes like GCC) problem:
* We have an input file with commands (aka source code)
* They should be understood (aka code should be parsed)
* They should move the robot (aka code should be executed)

I decided to have a very strict **syntax parser**:

| Instruction    | valid? | reason                                         |
|----------------|--------|------------------------------------------------|
| MOVE           | ✓      |                                                |
| move           | ✕      | Not upcased: each letter should be capitalized. |
| move 4,2,NORTH | ✕      | This instruction should have no parameter.      |
| PLACE 4,2, NORTH | ✕      | There should be no whitespace before NORTH.      |

The execution will be more tolerant: we will ignore all instructions that would through the robot out of the table. I would have preferred to raise an exception, but well, it's in the [spec](SPEC.md)!

# Modelization of the implementation
* Based on our concept, we have a class responsible for parsing the command (```Command```) and a class responsible for executing a command (```CommandExecutor```).
* ```CommandsList``` represents the input command file. ```Command``` represents a single line of this file.
* ```CommandsList``` herits Enumerable to have conveniants methods like ```command_list.each { |c| foo(c) }```. If you are not familiar with Enum, you can learn about it [here](https://blog.codeship.com/the-enumerable-module/) or [here in videos](https://www.youtube.com/watch?v=cs-mAtWRjCg).
* Based on our concept, we have 2 kinds of exceptions: ```ExecutionError```and ```SyntaxError```.
* A command may have parameters (e.g. ```PLACE 4,2,NORTH```) or not (e.g. ```REPORT```). This is represented in ruby using the * (splat) operator in class ```Command```. If you are not familiar with the splat operator,  you can learn more about it [here](http://andrewberls.com/blog/post/naked-asterisk-parameters-in-ruby) or [here in video](https://www.youtube.com/watch?v=znF5O8L7QMQ).


# Discussion
* It may seem a bit counterintuitive that the Robot is not responsible for the command he is receiving (like MOVE, RIGHT, LEFT, ...): in my design ```CommandExecutors``` is responsible for it. This modelization is for sure better: some commands depends not only on the robot, but also on the context. For instance, ```MOVE``` depends on the position/direction of the **robot**.  ```MOVE``` depends also on the size of **table** (in order not to fall). So we needed anyway a 3rd class to handle it.
* We could use some tricks to compact the execution of the command ```RIGHT``` and ```LEFT``` like:
```
directions_ordered = ["NORTH", "EAST", "SOUTH", "WEST"]
new_direction = (directions_ordered.index('WEST') +1 ) % directions_ordered.size
```
The trick looks cool, it compacts the code. But the code is after way more difficult to understand: the code is less ```KISS```. So I chose to stick to a naive ```IF ELSIF ... END``` implementation.
* As far of my understanding, there is a contradiction in the spec [spec](SPEC.md)
```
A robot that is not on the table can choose to ignore the MOVE, LEFT, RIGHT and REPORT commands.
```
and
```
The application should discard all commands in the sequence until a valid PLACEcommand has been executed.
```
In my implementation the command before the first ```PLACE``` are executed, but it does not matter because PLACE reset [the state of](https://en.wikipedia.org/wiki/Finite-state_machine) the robot. There is a spec that ensure it in the acceptance tests.
