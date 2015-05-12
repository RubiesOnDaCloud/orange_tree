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
    @age = @age + 1
    if @age >= MAX_AGE
      @dead = true
    end
  end

  def dead?
    @dead
  end

  def countTheOranges
    if @age > 3
      @oranges += (@age - 2) * 2
    else
      0
    end
  end

end

require 'rspec'

RSpec.describe OrangeTree do
  # Make an OrangeTree class
  it 'is a class' do
    expect(OrangeTree).to be_a(Class)
  end

  # It should have a height method
  describe '#height' do
    # which returns its height
    it 'returns the height of the tree' do
      expect(subject).to respond_to(:height)
      expect(subject.height).to be_zero
    end
  end

  # and a oneYearPasses method
  describe '#oneYearPasses' do
    # which, when called, ages the tree one year
    it 'ages the tree one year' do
      expect(subject).to respond_to(:oneYearPasses)
      subject.oneYearPasses
      expect(subject.age).to eq(1)
    end

    # Each year the tree grows taller (however much you think an orange tree should grow in a year)
    it 'causes the tree to grow one-tenth of its full height' do
      subject.oneYearPasses
      expect(subject.height).to eq(OrangeTree::FULL_HEIGHT / OrangeTree::AGE_TO_REACH_FULL_HEIGHT)
    end

    # and after some number of years (again, your call) the tree should die
    it 'dies after 40 years' do
      39.times { subject.oneYearPasses }
      expect(subject.dead?).to be false
      subject.oneYearPasses
      expect(subject.dead?).to be true
    end

    # For the first few years, it should not produce fruit
    it 'does not produce fruit in the first three years' do
      expect(subject.countTheOranges).to be_zero
      subject.oneYearPasses
      expect(subject.countTheOranges).to be_zero
      subject.oneYearPasses
      expect(subject.countTheOranges).to be_zero
      subject.oneYearPasses
      expect(subject.countTheOranges).to be_zero
    end

    # but after a while it should (produce fruit)
    it 'starts producing fruit in the fourth year' do
      4.times { subject.oneYearPasses }
      expect(subject.countTheOranges).to be > 0
    end

    # older trees produce more each year than younger trees
    it 'produces more fruit each year' do
      4.times { subject.oneYearPasses }
      last_years_fruit = subject.countTheOranges
      until subject.dead?
        subject.oneYearPasses
        this_years_fruit = subject.countTheOranges - last_years_fruit
        expect(this_years_fruit).to be > last_years_fruit
        last_years_fruit = this_years_fruit
      end
    end
  end
end
