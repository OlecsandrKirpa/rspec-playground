# frozen_string_literal: true

# Subject is a method that returns a instance of
# the object that is being tested
RSpec.describe Hash do
  it 'should start off empty and assign a key later' do
    expect(subject.length).to eq(0)
    subject[:some_key] = 'Some value'
    expect(subject.length).to eq(1)
  end

  it('should be empty') { expect(subject.length).to eq(0) }
end
