# frozen_string_literal: true

RSpec.describe '#even? method' do
  # it 'should return true if number is even'
  describe 'with even number' do
    it 'should return true' do
      expect(2.even?).to eq(true)
    end
  end

  # it 'should return false if number is odd'
  context 'with odd number' do
    it 'should return false' do
      expect(3.even?).to eq(false)
    end
  end
end
