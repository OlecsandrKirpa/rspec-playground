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
not_to_method_spec.rb
