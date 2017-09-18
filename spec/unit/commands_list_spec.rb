require 'spec_helper'

describe CommandsList do
  let(:command_list) { described_class.new(fixture_path) }

  context 'having a correct list of commands' do
    let(:fixture_path) { 'spec/fixtures/valid_command_list' }
    let(:lines_count)  { File.read(fixture_path).scan(/\n/).count }

    it 'has one command per line' do
      expect(command_list.count).to eq(lines_count)
    end
  end

  context 'having an incorrect list of commands' do
    let(:fixture_path) { 'spec/fixtures/invalid_command_list' }

    it 'raises an error' do
      expect { command_list.count }.to raise_error(ArgumentError)
    end
  end
end
