# frozen_string_literal: true

class King
  attr_reader :name

  def initialize(name = 'Arthur')
    @name = name
  end
end

RSpec.describe King do
  subject { described_class.new('Lancelot') }
  let(:bratan) { described_class.new('Bratan') }

  it 'represents a great king' do
    expect(subject.name).to eq('Lancelot')
  end

  it('bratan king name must be "Bratan"') { expect(bratan.name).to eq('Bratan') }

  it { expect(subject).to be_an_instance_of(described_class) }
end
