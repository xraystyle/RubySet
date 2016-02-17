class MySet

    include Enumerable
    
    # Create a new set. Create the internal hash used for storage,
    # with a default return value of false for absent keys.
    # Add the items from the array if one is given.
    def initialize(array = [])
        raise ArgumentError, 'New set must be given an array' unless array.class == Array
       
        @internal_hash = array.reduce(Hash.new(false)) do |hash, i|
            hash[i] = true
            hash
        end
    end

    # Is the key a member of the set?
    def [](key)
        @internal_hash[key]
    end

    alias_method :include?, :[]

    # Add something to the set.
    def add(key)
        @internal_hash[key] = true
    end

    alias_method :<<, :add

    # Define 'each' in the context of the set so that
    # all the Enumerable methods work properly.
    def each
        @internal_hash.each { |k,_| yield k }
    end

    # Return all members of the set as an array.
    def members
        @internal_hash.keys
    end

    # Show set intersection with a second set.
    # Returns the intersection as an array of objects.
    def intersection(other_set)
        requires_set(other_set, __method__)
        other_set.reduce([]) do |array, k|
            array << k if @internal_hash[k]
            array
        end
    end

    # Does the set intersect with another set? Returns
    # true if the sets intersect, false if they have no 
    # members in common.
    def intersect?(other_set)
        requires_set(other_set, __method__)
        self.intersection(other_set).any?
    end

    # Is the set a superset of the second? Returns true if all 
    # members of the second set are contained within the first.
    def superset?(other_set)
        requires_set(other_set, __method__)
        other_set.subset?(self)
    end

    # Return a new set with all the members of both sets.
    # Does NOT mutate the current set.
    def merge(other_set)
        requires_set(other_set, __method__)
        merged = MySet.new(self.members)
        other_set.each { |k| merged.add(k) }
        merged
    end

    # Returns the total number of members in the set.
    def length
        @internal_hash.length
    end

    # Compares the internal hash of one set to the internal hash
    # of the other. Hash equality checks for the same keys and values
    # in each set.
    def ==(other_set)
        requires_set(other_set, __method__)
        other_set.instance_eval { @internal_hash } == @internal_hash
    end

    # Remove a member from the set.
    def delete(key)
        @internal_hash.delete(key)
    end

    alias_method :pop, :delete

    # Is the set a subset of the passed set? Returns true or false.
    def subset?(other_set)
        requires_set(other_set, __method__)
        return true if self == other_set
        @internal_hash.keys.each { |k| return false unless other_set.include?(k) }
        true
    end

    # Is the set a proper subset of the passed set? Returns true or false.
    def proper_subset?(other_set)
        requires_set(other_set, __method__)
        return false if self == other_set
        return false unless self.subset?(other_set) && self.length < other_set.length
        true
    end

    private

    # Many of the set instance methods require a second set as a parameter for some type of comparison.
    # This verifies that the param is a set, and raises ArgumentError if it isn't.
    def requires_set(param, method_name)
        raise ArgumentError, "Method ##{method_name} requires a set as the parameter." unless param.class == MySet
    end

end




# test data
# @foo = MySet.new([:a, 12, "string", :baz, :foobar])
# @bar = MySet.new([:a, 12, "string", :baz, :foobar])
# @baz = MySet.new([:a, 12, "string", :somefoo, [2, 4, 7]])
# @qux = MySet.new([:a, 12, "string"])