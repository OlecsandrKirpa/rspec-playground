# frozen_string_literal: true

# ########################################
# First question's answer
# ########################################
RSpec.describe Array do
  it 'should start off empty and finish with length = 1' do
    expect(subject.length).to eq(0)
    subject.push('some value')
    expect(subject.length).to eq(1)
  end
end

# ########################################
# Second question's answer
# ########################################
# The subject method is a method that returns a instance of
# the object that is being tested.
# For example, inside
# `RSpec.describe Hash`
# the subject method returns a instance of Hash

# ########################################
# Third question's answer
# ########################################
# It's better to pass the class as argument to the describe method
# because it allows us to use the subject method
# and it's more readable
# and it adds some methods to the class
