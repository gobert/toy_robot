require 'spec_helper'

describe Table do
  let(:width)  { 5 }
  let(:height) { 5 }
  let(:table)  { described_class.new(width, height) }

  describe '#width' do
    subject { table.width }

    it { is_expected.to eq(width) }
  end

  describe '#height' do
    subject { table.height }

    it { is_expected.to eq(height) }
  end
end
