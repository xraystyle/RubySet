require_relative '../myset'
require 'rspec'

describe "MySet:" do

    before { @set = MySet.new }

    subject { @set }
    let(:new_set) { MySet.new([1,2,3,4,5]) }
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

    end

    describe "Creating a new set object" do
        it "returns an object of class MySet" do
            expect(@set.class).to eq(MySet)
        end

    end


    describe "#new method with an array as a paramater" do

        it "returns a set containing all elements of the array as members" do
            new_set.each do |i|
                expect(array.include?(i)).to be true
            end
        end

        it "should not contain any elements not in the array" do
            new_set.each do |i|
                expect(array_2.include?(i)).to be false
            end
        end

    end

    describe "#[] method" do
        before { @set }
      it "returns true if the set contains the given key" do
          #
      end
    end




# end of tests
end