# frozen_string_literal: true

RSpec.describe 'nested hooks' do
  before(:context) { puts 'OUTER before context' }
  before(:example) { puts 'OUTER before example' }

  it 'does basic math' do
    expect(1 + 1).to eq(2)
  end

  context 'with condition A' do
    before(:context) { puts 'INNER before context A' }
    before(:example) { puts 'INNER before example A' }

    it 'does some more basic math' do
      expect(1 + 1).to eq(2)
    end

    it 'does subtraction as well' do
      expect(5 - 3).to eq(2)
    end
  end
end
