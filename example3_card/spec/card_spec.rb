# frozen_string_literal: true

# Run specific file with:
# $ rspec spec/card_spec.rb

class Card
  attr_accessor :rank, :suit
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end

RSpec.describe Card do
  # SAME AS
  # before :example do
  # before do
  #   @card = Card.new((@rank = 'Ace'), (@suit = 'Spades'))
  # end

  # def card(rank: 'Ace', suit: 'Spades')
  #   @card ||= Card.new(rank, suit)
  # end
  # before do
  #   @card = nil
  # end

  let(:rank) { 'Ace' }
  let(:suit) { 'Spades' }
  let(:card) { Card.new(rank, suit) }

  # (SAME AS) specify 'has a type' do
  it 'has a rank' do
    expect(card.rank).to eq(rank)
  end

  it 'has a suit' do
    expect(card.suit).to eq(suit)
  end

  it 'can change rank' do
    card.rank = 'Queen'
    expect(card.rank).to eq('Queen')
  end

  it 'has a custom error message' do
    comparizon = 'Spades'
    expect(card.suit).to eq(comparizon), "I expected #{comparizon} but I got #{card.suit} instead!"
  end
end
