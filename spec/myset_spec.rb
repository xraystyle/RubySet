require_relative '../myset'
require 'rspec'

describe "MySet:" do

  before { @set = MySet.new }

  subject { @set }

  let(:new_set) { MySet.new([1,2,3,4,5]) }
  let(:intersected_set) { MySet.new([4,2,1,7,8]) }
  let(:proper_subset) { MySet.new([2,3,4]) }
  let(:improper_subset) { MySet.new([1,2,3,4,5]) }
  let(:not_a_subset) { MySet.new([10,11,12,13,14,15]) }
  let(:array) { [1,2,3,4,5] }
  let(:array_2) { [6,7,8] }

  describe "should respond to the following methods:" do
    it { should respond_to(:[]) }
    it { should respond_to(:add) }
    it { should respond_to(:include?) }
    it { should respond_to(:<<) }
    it { should respond_to(:each) }
    it { should respond_to(:intersection) }
    it { should respond_to(:intersect?) }
    it { should respond_to(:length) }
    it { should respond_to(:==) }
    it { should respond_to(:delete) }
    it { should respond_to(:pop) }
    it { should respond_to(:subset?) }
    it { should respond_to(:proper_subset?) }
    it { should respond_to(:superset?) }
    it { should respond_to(:to_a) }
    it { should respond_to(:merge) }
    it { should respond_to(:members) }
  end

  describe "Creating a new set object" do
    it "returns an object of class MySet" do
      expect(@set.class).to eq(MySet)
    end
  end

  # Test that iteration works. Also tests that a set initialized with an array
  # contains the elements from that array.
  shared_examples "iteration" do
    let(:temp_array) { Array.new }
    it "iteration yields each member of the set to the block" do
      new_set.each do |i|
        # all members of the set should also be in the array.
        expect(array.include?(i)).to be true
      end
    end
    it "iteration does not yield anything not a member of the set" do
      new_set.each do |i|
        temp_array << i
      end
      # no oddballs.
      expect(temp_array.sort).to eq([1,2,3,4,5]) # contents of array used to initialze new_set.
    end
  end

  # Many of the instance methods require a set as a parameter. 
  # Check that they raise an error if not passed another set as a param.
  shared_examples 'Parameter Must Be A Set' do |method|
    it "raises ArgumentError if the passed param is not also a set" do
      expect { @set.send(method, "not a set") }.to raise_error(ArgumentError, "Method ##{method} requires a set as the parameter.")
    end

    it "doesn't raise an error if the passed param is a set" do
      expect { @set.send(method, new_set) }.not_to raise_error
    end
  end

  # Start testing methods.
  describe "initializing with a bogus parameter" do
    it "raises ArgumentError" do
      expect { MySet.new("FooBar") }.to raise_error(ArgumentError, 'New set must be given an array')
    end 
  end

  describe "#new method with an array as a parameter" do
    # tests that it contains the elements of the array it was initialized with,
    # and none it wasn't.
    include_examples "iteration"

    it "returns a set of the correct length" do
      expect(array.length).to eq(new_set.length)
      expect(@set.length).to eq(0)
    end

    it "returns a set that includes all members of the passed array" do
      # tests the inverse of "iteration". All array members are
      # in the set, instead of all members of the set are in the array.
      array.each do |i|
        expect(new_set.include?(i)).to be true
      end
    end

  end

  describe "#[] method" do
    before { @set.add(:foo) }
    it "returns true if the set contains the given element" do
      expect(@set[:foo]).to be true
    end

    it "returns false if the set does not contain the given element" do
      expect(@set[:bar]).to be false            
    end
  end

  describe "#each method" do
    # it describes what it is.
    include_examples "iteration"  
  end

    describe "#add method" do
      before { @set.add(:bar) }
      
      it "adds a new member to the set" do
        expect(@set.include?(:bar)).to be true
      end

    end

    describe "#intersection method" do
      it "returns an array of items shared between both sets" do
        expect(new_set.intersection(intersected_set).sort).to eq([1,2,4])
        expect(new_set.intersection(proper_subset)).to eq([2,3,4])
        expect(new_set.intersection(improper_subset)).to eq([1,2,3,4,5])
        expect(new_set.intersection(not_a_subset)).to eq([])
      end
      include_examples 'Parameter Must Be A Set', :intersection
    end

    describe "#intersect? method" do
      it "returns true if the sets intersect" do
        expect(new_set.intersect?(proper_subset)).to be true
      end
      it "returns false if the sets don't intersect" do
        expect(new_set.intersect?(not_a_subset)).to be false
      end
      include_examples 'Parameter Must Be A Set', :intersect?
    end

    describe "#superset? method" do
      it "returns true if the set is a superset of the passed set" do
        expect(new_set.superset?(proper_subset)).to be true
      end
      it "returns false if the set is not a superset of passed set" do
        expect(new_set.superset?(not_a_subset)).to be false
      end
      include_examples 'Parameter Must Be A Set', :superset?
    end

    describe "#merge method" do
      let(:merged) { MySet.new([1,2,3,4,5,10,11,12,13,14,15]) }
      it "returns a correctly merged set" do
        expect(new_set.merge(not_a_subset) == merged).to be true
      end
      include_examples 'Parameter Must Be A Set', :merge
    end

    describe '#delete method' do
      it 'removes an object from the set' do
        new_set.delete(5)
        expect(new_set.include?(5)).to be false
      end
      it 'returns true if the object existed in the set and was removed' do
        expect(new_set.delete(4)).to be true
      end
      it 'returns nil if the object was not part of the set' do
        expect(new_set.delete(:foo)).to be nil          
      end
    end

    describe "#== method" do
      let(:set_1) { MySet.new([1,2,3]) }
      let(:set_2) { MySet.new([1,2,3]) }
      it "returns true if the sets contain exactly the same members" do
        expect(set_1 == set_2).to be true    
      end
      it "returns false if the sets don't contain exactly the same members" do
        expect(@set == set_1).to be false
      end
      include_examples 'Parameter Must Be A Set', :==
    end

# end of tests
end