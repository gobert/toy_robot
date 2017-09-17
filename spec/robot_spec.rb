require 'spec_helper'

describe Robot do
  let(:x)    { 4 }
  let(:y)    { 2 }
  let(:face) { 'NORTH' }

  describe '#report' do
    let(:report) { described_class.new(x, y, face).report }

    context 'having first returned object' do
      it 'returns x' do
        returned_x, = report
        expect(returned_x).to eq(x)
      end
    end

    context 'having secund returned object' do
      it 'returns x' do
        _, returned_y, = report
        expect(returned_y).to eq(y)
      end
    end

    context 'having third returned object' do
      it 'returns x' do
        _, _, returned_face = report
        expect(returned_face).to eq(face)
      end
    end
  end

  describe '#place' do
    subject { -> { robot.place(x, y, face) } }

    let(:robot) { described_class.new(20, 29, 'SOUTH') }

    it { is_expected.to change { robot.x }.to(x) }
    it { is_expected.to change { robot.y }.to(y) }
    it { is_expected.to change { robot.face }.to(face) }
  end
end
