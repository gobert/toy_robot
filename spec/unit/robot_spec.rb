require 'spec_helper'

describe Robot do
  let(:x) { 4 }
  let(:y) { 2 }
  let(:direction) { 'NORTH' }

  describe '#vector' do
    let(:robot) do
      robot = described_class.new
      robot.vector = x, y, direction
      robot
    end

    let(:vector) { robot.vector }

    context 'having first returned object' do
      it 'returns x' do
        returned_x, = vector
        expect(returned_x).to eq(x)
      end
    end

    context 'having secund returned object' do
      it 'returns x' do
        _, returned_y, = vector
        expect(returned_y).to eq(y)
      end
    end

    context 'having third returned object' do
      it 'returns x' do
        _, _, returned_direction = vector
        expect(returned_direction).to eq(direction)
      end
    end
  end

  describe '#vector=' do
    subject { -> { robot.vector = x, y, direction } }

    let(:robot) { described_class.new }

    it { is_expected.to change { robot.x }.to(x) }
    it { is_expected.to change { robot.y }.to(y) }
    it { is_expected.to change { robot.direction }.to(direction) }
  end
end
