class OrangeTree
  FULL_HEIGHT = 10.0 # meters
  AGE_TO_REACH_FULL_HEIGHT = 15.0 # years
  MAX_AGE = 40

  attr_reader :age
  # This is the same as these three lines of code:
  # def age
  #   @age
  # end

  def initialize
    @age = 0
    @dead = false
    @oranges = 0
  end

  def height
    (FULL_HEIGHT / AGE_TO_REACH_FULL_HEIGHT) * @age
  end

  def oneYearPasses
    @age += 1
    if @age > 3
      @oranges = @age * 2
    end
    if @age >= MAX_AGE
      @dead = true
    end
  end

  def dead?
    @dead
  end

  def countTheOranges
    @oranges
  end

  def pickAnOrange
    if @oranges.zero?
      "Oh noes! No more 🍊!"
    else
      @oranges -= 1
      "Yum! A delicious 🍊!"
    end
  end
end

require 'rspec'

RSpec.describe OrangeTree do
  it 'is a class' do
    expect(OrangeTree).to be_a(Class)
  end

  describe '#height' do
    it 'returns the height of the tree' do
      expect(subject).to respond_to(:height)
      expect(subject.height).to be_zero
    end
  end

  describe '#oneYearPasses' do
    it 'ages the tree one year' do
      expect(subject).to respond_to(:oneYearPasses)
      subject.oneYearPasses
      expect(subject.age).to eq(1)
    end

    it 'causes the tree to grow one-tenth of its full height' do
      subject.oneYearPasses
      expect(subject.height).to eq(OrangeTree::FULL_HEIGHT / OrangeTree::AGE_TO_REACH_FULL_HEIGHT)
    end

    it 'dies after 40 years' do
      39.times { subject.oneYearPasses }
      expect(subject.dead?).to be false
      subject.oneYearPasses
      expect(subject.dead?).to be true
    end

    it 'does not produce fruit in the first three years' do
      expect(subject.countTheOranges).to be_zero
      subject.oneYearPasses
      expect(subject.countTheOranges).to be_zero
      subject.oneYearPasses
      expect(subject.countTheOranges).to be_zero
      subject.oneYearPasses
      expect(subject.countTheOranges).to be_zero
    end

    it 'starts producing fruit in the fourth year' do
      4.times { subject.oneYearPasses }
      expect(subject.countTheOranges).to be > 0
    end

    it 'produces more fruit each year' do
      4.times { subject.oneYearPasses }
      last_years_fruit = subject.countTheOranges
      until subject.dead?
        subject.oneYearPasses
        this_years_fruit = subject.countTheOranges
        expect(this_years_fruit).to be > last_years_fruit
        last_years_fruit = this_years_fruit
      end
    end
  end

  describe '#pickAnOrange' do
    it 'reduces the orange count by one' do
      4.times { subject.oneYearPasses }
      before_count = subject.countTheOranges
      subject.pickAnOrange
      after_count = subject.countTheOranges
      expect(after_count).to eq(before_count - 1)
    end

    it 'returns a string telling you how delicious the orange was' do
      4.times { subject.oneYearPasses }
      expect(subject.pickAnOrange).to eq("Yum! A delicious 🍊!")
    end

    it 'tells you that there are no more oranges if there are no more oranges' do
      4.times { subject.oneYearPasses }
      subject.countTheOranges.times { subject.pickAnOrange }
      expect(subject.pickAnOrange).to eq("Oh noes! No more 🍊!")
    end

    it 'any oranges you don\'t pick one year fall off before the next year' do
      orange_tree1 = OrangeTree.new
      orange_tree2 = OrangeTree.new

      4.times { orange_tree1.oneYearPasses }
      4.times { orange_tree2.oneYearPasses }

      orange_tree1.pickAnOrange

      orange_tree1.oneYearPasses
      orange_tree2.oneYearPasses

      expect(orange_tree1.countTheOranges).to eq(orange_tree2.countTheOranges)
    end
  end
end
