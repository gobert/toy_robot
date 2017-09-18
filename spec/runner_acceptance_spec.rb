require 'spec_helper'

describe Runner do
  context 'when preventing robot to fall' do
    subject { -> { runner.run } }

    let!(:robot)    { Robot.new(0, 0, 'SOUTH') }
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
    let!(:robot1) { Robot.new(0, 0, 'SOUTH') }
    let!(:robot2) { Robot.new(0, 0, 'SOUTH') }
    let(:spec_path1) { 'spec/fixtures/acceptance_ignore1' }
    let(:spec_path2) { 'spec/fixtures/acceptance_ignore2' }
    let(:runner1) { described_class.new(spec_path1) }
    let(:runner2) { described_class.new(spec_path2) }

    before do
      runner1.run
      runner2.run
    end

    it 'finishes with same state than without the instruction before PLACE' do
      expect(robot1.x).to eq(robot2.x)
      expect(robot1.y).to eq(robot2.y)
      expect(robot1.direction).to eq(robot2.direction)
    end
  end
end
