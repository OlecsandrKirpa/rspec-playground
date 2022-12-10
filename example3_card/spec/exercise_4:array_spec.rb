# frozen_string_literal: true

RSpec.describe Array do
  subject(:sally) { %w[sa lly] }

  it('has a length of 2') { expect(sally.length).to eq(2) }

  it 'allows to remove an element' do
    sally.pop
    expect(sally.length).to eq(1)
  end
end
