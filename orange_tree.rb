class OrangeTree
  def initialize
    @age = 0
  end

  def height
    0.6666666666666666 * @age
  end

  def oneYearPasses
    @age = @age + 1
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
      expect(subject.oneYearPasses).to eq(1)
    end

    # Each year the tree grows taller (however much you think an orange tree should grow in a year)
    it 'causes the tree to grow one-tenth of its full height' do
      full_height = 10.0 # meters
      age_to_reach_full_height = 15.0 # years
      subject.oneYearPasses
      expect(subject.height).to eq(full_height / age_to_reach_full_height)
    end
  end
end
