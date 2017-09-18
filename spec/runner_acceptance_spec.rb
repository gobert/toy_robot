require 'spec_helper'

describe Runner do
  let!(:robot) { Robot.new(0, 0, 'SOUTH') }
  let(:runner) { described_class.new(spec_path) }

  before do
    allow(runner).to receive(:robot) { robot }
  end

  context 'when preventing robot to fall' do
    subject { -> { runner.run } }

    let(:spec_path) { 'spec/fixtures/acceptance_falling' }

    it { is_expected.not_to(change { robot.x }) }
    it { is_expected.not_to(change { robot.y }) }
    it { is_expected.not_to(change { robot.direction }) }
  end
end
