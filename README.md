# Rspec playgound
by Oleksandr Kirpachov

In questa repo saranno presenti alcune note su come utilizzare la gemma rspec di ruby per automatizzare i test.

## Link utili
- [Corso udemy](https://www.udemy.com/share/1023jY3@4bHwohSqZ_svd2PGwYD1ji66vw6hDFf9ZZu5pnVqD7JV3DtEKR0GbyKUlyJLJkZ7_g==/)
- [rspec website](https://rspec.info/)
- [rspec github](https://github.com/rspec/rspec-metagem)

## Scaletta

### Linear syntax
```rb
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

```

### Subject
```rb
# frozen_string_literal: true

# "String" is our class under test
# String.new is our subject
RSpec.describe String do
  it { expect(subject.length).to eq 0 }
  it { expect(subject).to be_empty }

  context 'with some content' do
    subject { 'some content' }
    it { expect(subject.length).to eq('some content'.length) }
    it { expect(subject).not_to be_empty }
  end
end
```

### Implicit subject
```rb
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

```
```rb
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

```

### Hooks - `before` and `after`
```rb
# frozen_string_literal: true

RSpec.describe 'before and after hooks' do
  before(:example) { puts 'before example hook' }
  after(:example) { puts 'after example hook' }

  # Run once before each 'context' or 'describe' call
  before(:context) { puts 'before context hook' }
  after(:context) { puts 'after context hook' }

  it 'is just a random example' do
    expect(5 * 4).to eq(20)
  end

  it 'is just another random example' do
    expect(3 - 2).to eq(1)
  end
end
```

### Nested hooks
```rb
# frozen_string_literal: true

RSpec.describe 'nested hooks' do
  before(:context) { puts 'OUTER before context' }
  before(:example) { puts 'OUTER before example' }

  it 'does basic math' do
    expect(1 + 1).to eq(2)
  end

  context 'with condition A' do
    before(:context) { puts 'INNER before context A' }
    before(:example) { puts 'INNER before example A' }

    it 'does some more basic math' do
      expect(1 + 1).to eq(2)
    end

    it 'does subtraction as well' do
      expect(5 - 3).to eq(2)
    end
  end
end
```

### Described class
```rb
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
```

### Context
Called `describe` too
```rb
# frozen_string_literal: true

RSpec.describe '#even? method' do
  # it 'should return true if number is even'
  describe 'with even number' do
    it 'should return true' do
      expect(2.even?).to eq(true)
    end
  end

  # it 'should return false if number is odd'
  context 'with odd number' do
    it 'should return false' do
      expect(3.even?).to eq(false)
    end
  end
end
```

### Overwrite let inside context
```rb
# frozen_string_literal: true

class ProgrammingLanguage
  attr_reader :name

  def initialize(name = 'Ruby')
    @name = name
  end
end

RSpec.describe ProgrammingLanguage do
  let(:language) { ProgrammingLanguage.new('Python') }

  it 'should store the name of the language' do
    expect(language.name).to eq('Python')
  end

  context 'with no argument' do
    let(:language) { ProgrammingLanguage.new }

    it 'should default to Ruby as the name' do
      expect(language.name).to eq('Ruby')
    end
  end

  describe 'with no argument' do
    it 'should have Python as the name' do
      expect(language.name).to eq('Python')
    end
  end
end

```

### Shared examples
```rb
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
```

### Shared context
```rb
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
```

### Not to method
```rb
# frozen_string_literal: true

RSpec.describe 'not_to method' do
  it 'check that values do not match' do
    expect('Hello').not_to eq 'hello'
  end

  it { expect('Hello').not_to eq 'hello' }
end
```

### Equality methods
```rb
# frozen_string_literal: true

# "eq" tests for value but ignores type
# "eql" tests for value and type
# "equal" tests for object identity
# "be" is an alias for "equal"
RSpec.describe 'equality matchers: eq, eql, equal and be' do
  let(:a) { 3.0 }
  let(:b) { 3 }

  # eq method tests for value but ignores type
  describe 'eq matcher' do
    it 'tests for value and ignores type' do
      expect(a).to eq(3)
      expect(b).to eq(3.0)
      expect(a).to eq(b)
    end
  end

  # eql method tests for value and type
  context 'eql matcher' do
    it 'tests for value, including same type' do
      expect(a).not_to eql(3)
      expect(b).not_to eql(3.0)
      expect(a).not_to eql(b)

      expect(a).to eql(3.0)
      expect(b).to eql(3)
    end
  end

  context 'equal and be matcher' do
    let(:c) { [1, 2, 3] }
    let(:d) { [1, 2, 3] }
    let(:e) { c }

    context 'cares about object identity' do
      it { expect(c).to equal(e) }
      it { expect(c).to be(e) }
      it { expect(c).not_to equal(d) }
      it { expect(e).not_to equal(d) }

      # expect(c).to eq(d) # value match
      # expect(c).to eql(d) # value, type match

      # expect(c).not_to equal(d) # different objects
      # expect(c).to equal(e) # same object
      # expect(c).to be(e) # same object
    end
  end
end
```

### Mathematica comparizon matchers
```rb
# frozen_string_literal: true

RSpec.describe 'comparizon matchers' do
  context 'allows for comparizon with built-in Ruby operators' do
    it { expect(10).to be > 5 }
    it { expect(5).to be < 10 }
    it { expect(6).to be > -1 }

    # 100 is my subject now
    context 100 do
      it { is_expected.to be > 0 }
      it { is_expected.to be < 200 }
      it { is_expected.to be == 100 }
    end
  end
end

```

### Predicate methods
```rb
# frozen_string_literal: true

# RSpec creates matches based on the ruby predicate methods.
# RSpec matcher ".be_even" comes from "#even?" Ruby method
RSpec.describe 'predicate methods and predicate matchers' do
  it 'can be tested with Ruby methods' do
    result = 16 / 2
    expect(result.even?).to eq(true)
  end

  it 'can be tested with predicate matchers' do
    expect(16 / 2).to be_even
  end

  describe 15 do
    it { is_expected.to be_odd }
    it { is_expected.not_to be_even }
    it { is_expected.not_to be_zero }
  end
end
```

### Predicate matchers dynamic matchers
Demo of the fact that the predicate
matchers in RSpec are not defined but
created dynamically based on the existing Ruby predicate methods
```rb
# frozen_string_literal: true

class MyGopnik
  attr_reader :year_of_birth
  def initialize(year_of_birth)
    @year_of_birth = year_of_birth
  end

  def has_odd_year_of_birth?
    @year_of_birth.odd?
  end

  def has_even_year_of_birth?
    @year_of_birth.even?
  end
end

RSpec.describe 'predicate methods on custom class' do
  [1990, 2005, 2003, 2002].each do |year|
    context "year #{year}" do
      subject { MyGopnik.new(year) }

      it "must have #{year.even? ? 'even' : 'odd'} year of birth" do
        is_expected.to be_has_even_year_of_birth if year.even?
        is_expected.not_to be_has_even_year_of_birth if year.odd?
      end
    end
  end
end
```

### `all` matcher
```rb
# frozen_string_literal: true

RSpec.describe 'all matcher' do
  context 'allows for aggregate checks' do
    # GOOD THING
    context [5, 7, 9] do
      it { is_expected.to all(be_odd) }
      it { is_expected.to all(be < 10) }
    end

    # BAD THING
    it 'checks all items one by one' do
      [5, 7, 9].each do |val|
        expect(val).to be_odd
      end
    end
  end
end
```

### `be` matcher
```rb
# frozen_string_literal: true

# File: be_matchers_spec.rb

# Falsy values: false, nil
RSpec.describe 'be matcher' do
  describe 'can test for truthiness' do
    [true, 'Hello', 1, 0, 115, -1, [], {}, "%%"].each do |item|
      describe item do
        it { is_expected.to be_truthy }
      end
    end
  end

  context 'can test for falsiness' do
    [false, nil, nil, false].each do |item|
      describe item do
        it { is_expected.to be_falsy }
        it { is_expected.not_to be_truthy }
      end
    end
  end

  context 'can test for nil' do
    describe 'nil' do
      it { is_expected.not_to be_nil }
    end

    let(:is_nil) { nil }
    it('testing nil value with #be_nil') do
      expect(is_nil).to be_nil
    end

    describe({a: 1, b: 2}) do
      it 'requiring missing key to a hash must return false' do
        expect(subject[:ciao]).to be_nil
      end
    end
  end
end
```

### `change` matcher
```rb
# frozen_string_literal: true

RSpec.describe 'change matcher' do
  describe [1, 2, 3] do
    it do
      # expect { subject.push(4) }.to(change { subject.length }.from(3).to(4))
      expect { subject.push(4) }.to(change { subject.length }.by(1))
    end

    it do
      expect { subject.pop }.to(change { subject.length }.by(-1))
    end
  end
end
```

### `contain_exacly` matcher
```rb
# frozen_string_literal: true

# Does not care about the order of the elements
RSpec.describe 'contain_exactly matcher' do
  context [1, 2, 3] do
    it { is_expected.to contain_exactly(3, 2, 1) }
    it { is_expected.to contain_exactly(1, 3, 2) }
    it { is_expected.not_to contain_exactly(4, 3, 2) }
    it { is_expected.not_to contain_exactly(1, 2) }
  end
end
```

### `start_with` and `end_with` matchers
```rb
# frozen_string_literal: true

# Does not care about the order of the elements
RSpec.describe 'start_with and end_with matcher' do
  context [1, 2, 3] do
    it { is_expected.to start_with(1) }
    it { is_expected.to end_with(3) }
  end

  context 'bratan' do
    it { is_expected.to start_with 'b' }
    it { is_expected.to start_with 'brat' }
    it { is_expected.to end_with 'an' }
    it { is_expected.to end_with 'n' }
  end
end
```

### `have_attributes` matcher
```rb
# frozen_string_literal: true

class ProfessionalWrestler
  attr_reader :name, :move
  def initialize(name, move)
    @name = name
    @move = move
  end

  def to_s
    "#{super}: {name: #{name.inspect}, move: #{move.inspect}}"
  end
end

# Does not care about the order of the elements
RSpec.describe 'have_attributes matcher' do
  describe ProfessionalWrestler.new('Sasha', 'Click sulla tastiera') do
    describe 'checks for object attriute and proper values' do
      it { is_expected.to have_attributes({ name: 'Sasha' }) }
      it { is_expected.to have_attributes({ move: 'Click sulla tastiera' }) }
    end
  end
end
```

### `include` matcher
```rb
# frozen_string_literal: true

RSpec.describe 'include matcher' do
  describe 'hot cholocate' do
    it { is_expected.to include('cholocate') }
    it { is_expected.to include('hot') }
    it { is_expected.to include(' ') }
  end

  describe [10, 20, 30] do
    it { is_expected.to include(10, 20) }
    it { is_expected.to include(20) }
    it { is_expected.to include(30) }
  end

  describe({ a: 1, b: 2 }) do
    it { is_expected.to include({ a: 1, b: 2 }) }
    it { is_expected.to include({ a: 1 }) }
    it { is_expected.not_to include({ aaa: 1 }) }

    it { is_expected.to include(:a, :b) }
    it { is_expected.to include(:b) }
  end
end
```

### `raise_error` matcher
```rb
# frozen_string_literal: true

RSpec.describe 'raise_error matcher' do
  def some_method
    x
  end

  it { expect { some_method }.to raise_error(NameError) }

  it { expect { 1 / 0 }.to raise_error(ZeroDivisionError) }
end
```

### `respond_to` matcher
```rb
# frozen_string_literal: true

class HotChocolate
  def drink
    'Delicius'
  end

  def discard
    'FLOP!'
  end

  def purchase(number)
    "Purchase ##{number}"
  end
end

class Coffee
  def drink; end
  def discard; end
  def purchase(number); end
end

RSpec.describe 'respond_to matcher' do
  describe HotChocolate do
    it { is_expected.to respond_to(:drink, :discard, :purchase) }
    it { is_expected.to respond_to(:purchase).with(1).arguments }
  end

  describe Coffee do
    it { is_expected.to respond_to(:drink, :discard, :purchase) }
  end
end
```

### `satisfy` matcher
```rb
# frozen_string_literal: true

RSpec.describe 'satisfy matcher' do
  subject { 'racecars' }

  it 'is a palidrome' do
    is_expected.to(satisfy { |v| v.reverse == v })
  end

  it 'can accept custom error message' do
    is_expected.to(satisfy('to be a palindrome') { |v| v.reverse == v })
  end
end
```

### `not_to` method
```rb
# frozen_string_literal: true

RSpec.describe 'not_to method' do
  context 'checks for the inverse of a matcher' do
    it { expect(5).not_to eq(10) }
    it { expect('Ciao').not_to equal('ciao') }
    it { expect({ name: 'ciao' }).not_to equal({ name: 'ciao' }) }
    it { expect(10).not_to be_odd }
    it { expect(%w[c i a o]).not_to be_empty }
  end
end
```

### Compound expectations
```rb
RSpec.describe 'Compound expectations' do
  context 25 do
    # GOOD
    it { is_expected.to((be > 20).and(be_odd)) }

    # BAD
    it { is_expected.to be > 20 }
    it { is_expected.to be_odd }
  end

  context 'caterpillar' do
    it { is_expected.to(start_with('cat').and(end_with('pillar'))) }
  end

  context %i[usa canada mexico] do
    it { expect(subject.sample).to eq(:usa).or(eq(:canada)).or(eq(:mexico)) }
  end
end
```

## Mocking
To mock == To Emulate
### Doubles and Allow method
```rb
# frozen_string_literal: true

RSpec.describe 'a random double' do
  # Syntax 1:
  # double('name', method: return_value)
  it 'only allows defined methods to be invoked' do
    stuntman = double('Mr. danger', fall_off_ladder: 'Ouch', light_on_fire: true)

    expect(stuntman.fall_off_ladder).to eq('Ouch')
    expect(stuntman.light_on_fire).to eq(true)
  end

  # Syntax 2:
  # a = double('name')
  # allow(a).to receive(:method).and_return(return_value)
  it '"allow" with "receive" example' do
    stuntman = double('Mr. danger')

    # We want to allow the stuntman to receive a specific method
    allow(stuntman).to receive(:method_with_nil_return)
    allow(stuntman).to receive(:fall_off_ladder).and_return('Ouch')

    expect(stuntman.method_with_nil_return).to be_nil
  end

  # Syntax 3:
  # a = double('name')
  # allow(a).to receive_messages(method: return_value, method: return_value)
  it '"allow" with "receive_messages" example' do
    stuntman = double('Mr. danger')
    allow(stuntman).to receive_messages(fall_off_ladder: 'Ouch', light_on_fire: true)

    expect(stuntman.fall_off_ladder).to eq('Ouch')
    expect(stuntman.light_on_fire).to eq(true)
  end
end
```
```rb
# frozen_string_literal: true

RSpec.describe 'allow_method review' do
  it 'can customize methods for doubles' do
    calculator = double
    allow(calculator).to receive(:add).and_return(15)

    expect(calculator.add).not_to be_nil
    expect(calculator.add).to be 15
  end

  describe 'can stub one or methods on a real object' do
    let(:my_arr) { [1, 2, 3] }
    it { expect(my_arr.sum).to eq 6 }

    it 'adding some methods to an Array with allow' do
      allow(my_arr).to receive(:sum).and_return(2)

      expect(my_arr.sum).to eq 2
      my_arr.push(5)
      expect(my_arr).to include(1, 2, 3, 5)
      expect(my_arr.sum).to eq(2)
    end

    it 'can return multiple return values in sequence' do
      # (sush as #pop on Array)
      # our Array is [:b, :c]
      mock_array = double
      allow(mock_array).to receive(:pop).and_return(:c, :d, nil)
      expect(mock_array.pop).to eq(:c)
      expect(mock_array.pop).to eq(:d)
      expect(mock_array.pop).to be_nil
      expect(mock_array.pop).to be_nil
      expect(mock_array.pop).to be_nil
      expect(mock_array.pop).to be_nil
    end
  end
end
```
```rb
# frozen_string_literal: true

RSpec.describe 'Mocking array #first method' do
  # but considering the param passed to it
  it 'can return different values based on the argument' do
    three_element_array = double # [1, 2, 3]

    allow(three_element_array).to receive(:first).with(no_args).and_return(1)
    allow(three_element_array).to receive(:first).with(1).and_return([1])
    allow(three_element_array).to receive(:first).with(2).and_return([1, 2])
    allow(three_element_array).to receive(:first).with(3).and_return([1, 2, 3])
    allow(three_element_array).to receive(:first).with(be >= 3).and_return([1, 2, 3])

    expect(three_element_array.first).to eq 1
    expect(three_element_array.first(1)).to eq [1]
    expect(three_element_array.first(2)).to eq [1, 2]
    expect(three_element_array.first(3)).to eq [1, 2, 3]
    expect(three_element_array.first(300)).to eq [1, 2, 3]
  end
end
```

### Exercise 10
```rb
# frozen_string_literal: true

RSpec.describe 'Exercize_10 - doubles' do
  # Create a double with the name "Database Connection".
  # The double should have a method called connect that returns the value true.
  # The double also have a method called disconnect that returns the value "Goodbye".
  # The double's methods should be assigned in the initial invocation of the double method.
  # Write two expectations, one for connect and one for disconnect, that confirms the return value of each.
  # Assign the double to the variable db.
  it 'part 1' do
    db = double('Database Connection', connect: true, disconnect: 'Goodbye')
    expect(db.connect).to eq(true)
    expect(db.disconnect).to eq('Goodbye')
  end

  # Create a double with the name "File System". Assign the double to the variable fs.
  # Using the allow method, give the double a read method that returns the value "Romeo and Juliet".
  # Using the allow method, give the double a write method that returns the value false.
  it 'part 2' do
    fs = double('File System')
    allow(fs).to receive(:read).and_return('Romeo and Juliet')
    allow(fs).to receive_messages(write: false)

    expect(fs.read).to eq('Romeo and Juliet')
    expect(fs.write).to eq(false)
  end
end
```

### Movie spec
See `movie_spec.rb`

### Instance doubles
```rb
# frozen_string_literal: true

class Person
  def sayhi
    sleep 3
    'Hello'
  end
end

RSpec.describe Person do
  describe 'regular double' do
    it 'can implement any method' do
      # Method #bratan does not exist on class Person
      person = double(sayhi: 'Hello', bratan: 20)
      expect(person.sayhi).to eq('Hello')
    end
  end

  describe 'Instance double - super cool double' do
    it 'can implement only Person methods' do
      person = instance_double(Person, sayhi: 'Hello')
      # expect(person.sayhi).to eq('Hello')

      # Going to throw an error cuz #sayhi does not have params
      # allow(person).to receive(:sayhi).with(3, 10).and_return('Hello')
    end
  end
end
```

### Class double

```rb
# frozen_string_literal: true

def Deck
  class << self
    def build
      # returns array of cards
    end
  end
end

class CardGame
  attr_accessor :cards

  def start
    @cards = Deck.build
  end
end

RSpec.describe CardGame do
  it 'can only implement call methods that are defined on a class' do
    # "as_stubbed_const" replaces any "Deck" constant reference with this double. Useful when Deck is not defined.
    deck_klass = class_double('Deck', build: %w[Ace Queen]).as_stubbed_const

    expect(deck_klass).to receive(:build).once
    subject.start
    expect(subject.cards).to eq(%w[Ace Queen])
  end
end
```

### Spies
Alternative to double
```rb
# frozen_string_literal: true

RSpec.describe 'Spies' do
  let(:animal) { spy('Lion', roar: 'Roar!!!') }

  it 'used to confirm that a message has been received' do
    # in other words, that a method has been called.
    animal.roar
    expect(animal).to have_received(:roar).once
    animal.roar

    expect(animal).to have_received(:roar).twice

    expect(animal).not_to have_received(:eat_human)
  end

  it 'resets between examples' do
    expect(animal).not_to have_received(:roar)
  end

  it 'retais the same funcionalities of a double' do
    animal.roar
    animal.roar
    animal.roar('Miao')
    expect(animal).to have_received(:roar).exactly(3).times
    expect(animal).to have_received(:roar).at_least(2).times
    expect(animal).to have_received(:roar).at_least(2).times.with(no_args)
    expect(animal).to have_received(:roar).once.with('Miao')
  end
end
```
```rb
# frozen_string_literal: true

class Garage
  attr_accessor :storage

  def initialize
    @storage = []
  end

  def add_to_collection(model)
    @storage << Car.new(model)
  end
end

class Car
  attr_accessor :model

  def initialize(model)
    @model = model
  end
end

RSpec.describe 'spy a method on a real class' do
  # Need to fake Car to be indipendent from car.
  describe Garage do
    let(:car) { instance_double(Car) }

    before do
      allow(Car).to receive(:new).and_return(car)
    end

    it 'adds car to its storage' do
      subject.add_to_collection('Honda Civic')
      expect(Car).to have_received(:new).with('Honda Civic')
      expect(subject.storage.length).to eq(1)
      expect(subject.storage.first).to eq(car)
    end
  end
end
```