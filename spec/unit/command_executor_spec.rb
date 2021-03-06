require 'spec_helper'

describe CommandExecutor do
  subject do
    lambda do
      executor = described_class.new(robot, table)
      executor.execute(init)
      executor.execute(command)
    end
  end

  let(:x)     { 4 }
  let(:y)     { 2 }
  let(:face)  { 'WEST' }
  let(:table) { Table.new(5, 5) }
  let(:robot) { Robot.new }
  let(:init)  { Command.new('PLACE', 0, 0, 'NORTH') }

  describe '#execute having PLACE' do
    context 'when placing the robot on the table' do
      let(:command) { Command.new('PLACE', x, y, face) }

      it { is_expected.to change { robot.x }.to(x) }
      it { is_expected.to change { robot.y }.to(y) }
      it { is_expected.to change { robot.direction }.to(face) }
    end

    context 'when placing the robot out the table' do
      let(:x)       { 142 }
      let(:y)       { 142 }
      let(:command) { Command.new('PLACE', x, y, face) }

      it { is_expected.to raise_error(ToyRobot::ExecutionError) }
    end
  end

  describe '#execute having MOVE' do
    let(:command) { Command.new('MOVE') }

    context 'when moving the robot on the table' do
      context 'when robot is facing NORTH' do
        let(:init) { Command.new('PLACE', 1, 1, 'NORTH') }

        it { is_expected.to change { robot.y }.from(nil).to(2) }
      end

      context 'when robot is facing EAST' do
        let(:init)  { Command.new('PLACE', 1, 1, 'EAST') }

        it { is_expected.to change { robot.x }.from(nil).to(2) }
      end

      context 'when robot is facing SOUTH' do
        let(:init)  { Command.new('PLACE', 1, 1, 'SOUTH') }

        it { is_expected.to change { robot.y }.from(nil).to(0) }
      end

      context 'when robot is facing WEST' do
        let(:init)  { Command.new('PLACE', 1, 1, 'WEST') }

        it { is_expected.to change { robot.x }.from(nil).to(0) }
      end
    end

    context 'when moving the robot out the table' do
      context 'when robot is facing NORTH' do
        let(:init)  { Command.new('PLACE', 1, table.height, 'NORTH') }

        it { is_expected.to raise_error(ToyRobot::ExecutionError) }
      end

      context 'when robot is facing EAST' do
        let(:init)  { Command.new('PLACE', table.width, 1, 'EAST') }

        it { is_expected.to raise_error(ToyRobot::ExecutionError) }
      end

      context 'when robot is facing SOUTH' do
        let(:init)  { Command.new('PLACE', 1, 0, 'SOUTH') }

        it { is_expected.to raise_error(ToyRobot::ExecutionError) }
      end

      context 'when robot is facing WEST' do
        let(:init)  { Command.new('PLACE', 0, 1, 'WEST') }

        it { is_expected.to raise_error(ToyRobot::ExecutionError) }
      end
    end
  end

  describe '#execute having RIGHT' do
    let(:command) { Command.new('RIGHT') }

    context 'when robot is facing NORTH' do
      let(:init)  { Command.new('PLACE', 1, 1, 'NORTH') }

      it { is_expected.to change { robot.direction }.to('EAST') }
    end

    context 'when robot is facing EAST' do
      let(:init)  { Command.new('PLACE', 1, 1, 'EAST') }

      it { is_expected.to change { robot.direction }.to('SOUTH') }
    end

    context 'when robot is facing SOUTH' do
      let(:init)  { Command.new('PLACE', 1, 1, 'SOUTH') }

      it { is_expected.to change { robot.direction }.to('WEST') }
    end

    context 'when robot is facing WEST' do
      let(:init)  { Command.new('PLACE', 1, 1, 'WEST') }

      it { is_expected.to change { robot.direction }.to('NORTH') }
    end
  end

  describe '#execute having LEFT' do
    let(:command) { Command.new('LEFT') }

    context 'when robot is facing NORTH' do
      let(:init)  { Command.new('PLACE', 1, 1, 'NORTH') }

      it { is_expected.to change { robot.direction }.to('WEST') }
    end

    context 'when robot is facing EAST' do
      let(:init)  { Command.new('PLACE', 1, 1, 'EAST') }

      it { is_expected.to change { robot.direction }.to('NORTH') }
    end

    context 'when robot is facing SOUTH' do
      let(:init)  { Command.new('PLACE', 1, 1, 'SOUTH') }

      it { is_expected.to change { robot.direction }.to('EAST') }
    end

    context 'when robot is facing WEST' do
      let(:init)  { Command.new('PLACE', 1, 1, 'WEST') }

      it { is_expected.to change { robot.direction }.to('SOUTH') }
    end
  end

  describe '#execute having REPORT' do
    let(:command) { Command.new('REPORT') }
    let(:report)  { subject.call }
    let(:init)    { Command.new('PLACE', 1, 1, 'WEST') }

    context 'having first returned object' do
      it 'returns x' do
        x, = report
        expect(x).to eq(robot.x)
      end
    end

    context 'having secund returned object' do
      it 'returns y' do
        _, y, = report
        expect(y).to eq(robot.y)
      end
    end

    context 'having third returned object' do
      it 'returns direction' do
        _, _, direction = report
        expect(direction).to eq(robot.direction)
      end
    end
  end
end
