# frozen_string_literal: true

RSpec.describe Hash do
  # Similar to
  # let(:subject) { Hash.new }
  subject(:my_hash) { { key: :value } }

  it 'has one key-value pair' do
    expect(subject.length).to eq(1)
  end

  it 'must allow key-value pair to be added' do
    subject[:another_key] = 'another_value'
    expect(subject.length).to eq(2)
  end

  it { is_expected.to eq(key: :value) }

  it 'must refer to the same hash object' do
    expect(subject).to be(my_hash)
  end

  context 'nested example with two key-value pairs' do
    subject { { key1: :value1, key2: :value2 } }

    it 'has two key-value pairs' do
      expect(subject.length).to eq(2)
    end
  end
end
