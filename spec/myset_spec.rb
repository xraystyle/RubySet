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

    
             
    shared_examples "iteration" do

        it "iteration yields each member of the set to the block" do
            new_set.each do |i|
                expect(array.include?(i)).to be true
            end
        end

        it "does not yield anything not a member of the set" do
            new_set.each do |i|
                expect(array_2.include?(i)).to be false
            end
        end

    end

    

    describe "#new method with an array as a paramater" do
        # tests that it contains the elements of the array it was initialized with,
        # and none it wasn't.
        it_behaves_like "iteration"

        it "is the right length" do
            expect(array.length).to eq(new_set.length)
            expect(@set.length).to eq(0)
        end

        it "includes all members of it's array paramater" do
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
        it_behaves_like "iteration"  
    end

    describe "#add method" do
        before { @set.add(:bar) }
        
        it "adds a new member to the set" do
            expect(@set.include?(bar)).to be true
        end
      
    end



# end of tests
end