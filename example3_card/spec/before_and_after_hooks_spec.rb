# frozen_string_literal: true

RSpec.describe 'before and after hooks' do
  before(:example) { puts 'before example hook' }
  after(:example) { puts 'after example hook' }

  # Run once before each 'context' or 'describe' call
  before(:context) { puts 'before context hook' }
  after(:context) { puts 'after context hook' }

  it 'is just a random example' do
    expect(5 * 4).to eq(20)
  end

  it 'is just another random example' do
    expect(3 - 2).to eq(1)
  end
end
