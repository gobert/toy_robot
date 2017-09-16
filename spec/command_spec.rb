require 'spec_helper'

describe Command do
  describe '#correct?' do
    subject { -> { described_class.new(*instructions).correct? } }

    let(:is_correct) { subject.call }

    context 'when command does not exist' do
      let(:instructions) { ['FOO'] }

      it { is_expected.to raise_error(Command::SyntaxError) }
    end

    context 'having PLACE' do
      context 'when X does not represent an integer' do
        let(:instructions) { ['PLACE', '-pi', 0, 'NORTH'] }

        it { is_expected.to raise_error(ArgumentError) }
      end

      context 'when Y does not represent an integer' do
        let(:instructions) { ['PLACE', 0, '-pi', 'NORTH'] }

        it { is_expected.to raise_error(ArgumentError) }
      end

      context 'when F does not represent one of the 4 cardinal points' do
        let(:instructions) { ['PLACE', 4, 2, 'regarding FOO'] }

        it { is_expected.to raise_error(Command::SyntaxError) }
      end

      context 'when PLACE is correct' do
        let(:instructions) { ['PLACE', 4, 2, 'NORTH'] }

        it { expect(is_correct).to eq(true) }
      end
    end

    context 'having MOVE' do
      let(:instructions) { ['MOVE', 4, 2, 'NORTH'] }

      context 'when MOVE has arguments' do
        it { is_expected.to raise_error(Command::SyntaxError) }
      end

      context 'when MOVE is correct' do
        let(:instructions) { ['MOVE'] }

        it { expect(is_correct).to eq(true) }
      end
    end

    context 'having LEFT' do
      let(:instructions) { ['LEFT', 4, 2, 'NORTH'] }

      context 'when LEFT has arguments' do
        it { is_expected.to raise_error(Command::SyntaxError) }
      end

      context 'when LEFT is correct' do
        let(:instructions) { ['LEFT'] }

        it { expect(is_correct).to eq(true) }
      end
    end

    context 'having RIGHT' do
      let(:instructions) { ['RIGHT', 4, 2, 'NORTH'] }

      context 'when RIGHT has arguments' do
        it { is_expected.to raise_error(Command::SyntaxError) }
      end

      context 'when RIGHT is correct' do
        let(:instructions) { ['RIGHT'] }

        it { expect(is_correct).to eq(true) }
      end
    end

    context 'having REPORT' do
      let(:instructions) { ['REPORT', 4, 2, 'NORTH'] }

      context 'when REPORT has arguments' do
        it { is_expected.to raise_error(Command::SyntaxError) }
      end

      context 'when REPORT is correct' do
        let(:instructions) { ['REPORT'] }

        it { expect(is_correct).to eq(true) }
      end
    end
  end
end
