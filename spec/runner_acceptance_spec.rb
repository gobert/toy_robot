require 'spec_helper'

describe Runner do
  context 'when preventing robot to fall' do
    subject { -> { runner.run } }

    let(:robot) do
      robot = Robot.new
      robot.vector = 0, 0, 'SOUTH'
      robot
    end
    let(:runner)    { described_class.new(spec_path) }
    let(:spec_path) { 'spec/fixtures/acceptance_falling' }

    before do
      allow(runner).to receive(:robot) { robot }
    end

    it { is_expected.not_to(change { robot.x }) }
    it { is_expected.not_to(change { robot.y }) }
    it { is_expected.not_to(change { robot.direction }) }
  end

  context 'when command before PLACE' do
    let(:robot)     { Robot.new }
    let(:spec_path) { 'spec/fixtures/acceptance_ignore' }
    let(:runner)    { described_class.new(spec_path) }
    let(:executor)  { CommandExecutor.new(robot, Table.new(5, 5)) }

    before do
      allow(runner).to receive(:robot)    { robot }
      allow(runner).to receive(:executor) { executor }
    end

    it 'does not execute command REPORT' do
      expect(executor).not_to receive(:execute_place)
    end

    it 'does not execute command MOVE' do
      expect(executor).not_to receive(:execute_move)
    end

    it 'does not execute command LEFT' do
      expect(executor).not_to receive(:execute_left)
    end

    it 'does not execute command RIGHT' do
      expect(executor).not_to receive(:execute_right)
    end
  end
end
