# frozen_string_literal: true

RSpec.describe 'shorthand syntax' do
  subject { 5 }

  describe 'with classic syntax' do
    it 'should be a integer' do
      expect(subject).to be_an(Integer)
    end
  end

  context 'with one-liner syntax' do
    it { is_expected.to be_an(Integer) }
    it { is_expected.to eq(5) }
  end
end
