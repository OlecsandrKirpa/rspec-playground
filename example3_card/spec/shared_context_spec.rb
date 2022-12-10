# frozen_string_literal: true

RSpec.shared_context 'my shared context' do
  before do
    @foo = 1
  end

  def some_helper_method
    'Bratan'
  end

  let(:bar) { 2 }
end

RSpec.describe 'first example group' do
  include_context 'my shared context'

  it 'calling method helper will receive "Bratan" string' do
    expect(some_helper_method).to eq('Bratan')
  end
end
