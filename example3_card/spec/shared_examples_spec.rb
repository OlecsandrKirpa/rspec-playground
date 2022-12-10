# frozen_string_literal: true

# Testing #length method for Array, String, Hash, and SausageLink

# Shared examples here
RSpec.shared_examples 'Ruby object with (#length =~ Integer)' do
  it { is_expected.to respond_to(:length) }
  it { expect(subject.length).to be_a(Integer) }
end

class SausageLink
  def length
    5
  end
end

RSpec.describe Array do
  include_examples 'Ruby object with (#length =~ Integer)'
  subject { %w[s a l l y] }
end

RSpec.describe String do
  include_examples 'Ruby object with (#length =~ Integer)'
  subject { 'sally' }
end

RSpec.describe Hash do
  include_examples 'Ruby object with (#length =~ Integer)'
  subject { { s: 1, a: 2, l: 3, l2: 4, y: 5 } }
end

RSpec.describe SausageLink do
  include_examples 'Ruby object with (#length =~ Integer)'
end
