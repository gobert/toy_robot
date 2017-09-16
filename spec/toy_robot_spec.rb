require 'spec_helper'

describe ToyRobot do
  it 'tests that basic set up works' do
    expect(described_class.new.delegate).to eq('bar')
  end
end
