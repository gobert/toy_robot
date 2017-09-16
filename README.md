# Toy Robot Simulator
![Travis build information for branch master](https://api.travis-ci.org/gobert/toy_robot.svg?branch=master)

This is a simulator of a robot that evolve on a 5x5 square tabletop. As input it takes a files like:

```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```
The ```REPORT``` will announce the X,Y and F of the robot: it will be our output on STDOUT.

# Set up
* Install ruby 2.4.1. For instance using rvm ``` rvm install 2.4.1```
* Install dependencies ```bundle install```

# Test suite
On top of each commit, all tests should pass:
```
  bundle exec rspec -- spec/
```
# Check code syntax
On top of each commit, no offense should be detected
```
  bundle exec rubocop -c .rubocop-validation.yml -- .
```
This will check the core offenses. The other "offenses" are related to the code quality. They will handled in ```.rubocop.yml```: so advices are displayed on the IDE but they don't block the deployment.

# Concepts
This kind of problem is a translation / compilator (yes like GCC) problem:
* We have an input file of instructions (aka source code)
* They should be understood (aka instructions should be parsed)
* They should move the robot (aka instructions should be executed)

I decided to have a very strict **syntax parser**:

| Instruction    | valid? | reason                                         |
|----------------|--------|------------------------------------------------|
| MOVE           | ✓      |                                                |
| move           | ✕      | Not upcased: each letter should be capitalized |
| move,4,2,NORTH | ✕      | This instruction should have no parameter      |
| PLACE,4,2, NORTH | ✕      | There should be no whitespace before NORTH      |

The execution will be more tolerant: we will ignore all instructions that would through the robot out of the table. I would have preferred to raise an exception, but well, it's the [spec](SPEC.md)!
