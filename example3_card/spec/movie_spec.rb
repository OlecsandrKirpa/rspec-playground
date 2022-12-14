# frozen_string_literal: true

# The Actor of our Film.
class Actor
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def ready?
    sleep 3

    true
  end

  def act
    'I love you baby'
  end

  def fall_off_ladder
    "fuck off"
  end

  def light_on_fire
    false
  end
end

# Our Movie.
class Movie
  attr_reader :actor

  def initialize(actor)
    @actor = actor
  end

  def start_shooting
    return unless actor.ready?

    actor.act
    actor.fall_off_ladder
    actor.light_on_fire
    actor.act
  end
end

# What is going to happen
# actor = Actor.new('Angelina Jolie')
# movie = Movie.new(actor)
# movie.start_shooting

RSpec.describe Movie do
  let(:actor) do
    double(
      'My fucking actor',
      fall_off_ladder: 'Lets do it',
      act: 'Ciao bella',
      light_on_fire: false,
      ready?: true
    )
  end

  subject { described_class.new(actor) }

  describe '#start_shooting' do
    it 'expects an actor to do 3 actions' do
      expect(actor).to receive(:ready?).at_least(1).times
      expect(actor).to receive(:act).twice
      expect(actor).to receive(:fall_off_ladder).exactly(1).times
      expect(actor).to receive(:light_on_fire).at_most(1).times

      subject.start_shooting
    end
  end
end
