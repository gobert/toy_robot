require 'spec_helper'

describe Runner do
  let!(:robot) { Robot.new(0, 0, 'NORTH') }
  let(:runner) { described_class.new(spec_path) }

  before do
    allow(runner).to receive(:robot) { robot }
  end

  context 'Example a' do
    subject { -> { runner.run } }

    let(:spec_path) { 'spec/fixtures/functional_a' }

    it { is_expected.not_to(change { robot.x }) }
    it { is_expected.to(change { robot.y }.to(1)) }
    it { is_expected.not_to(change { robot.direction }) }
  end

  context 'Example b' do
    subject { -> { runner.run } }

    let(:spec_path) { 'spec/fixtures/functional_b' }

    it { is_expected.not_to(change { robot.x }) }
    it { is_expected.not_to(change { robot.y }) }
    it { is_expected.to(change { robot.direction }.to('WEST')) }
  end

  context 'Example c' do
    subject { -> { runner.run } }

    let(:spec_path) { 'spec/fixtures/functional_c' }

    it { is_expected.to(change { robot.x }.to(3)) }
    it { is_expected.to(change { robot.y }.to(3)) }
    it { is_expected.not_to(change { robot.direction }) }
  end
end
