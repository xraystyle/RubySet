class MySet

    include Enumerable
    
    def initialize(array = [])
        @internal_hash = array.reduce(Hash.new(false)) do |hash, i|
            hash[i] = true
            hash
        end
    end


    def [](key)
        @internal_hash[key]
    end

    alias_method :include?, :[]

    def add(key)
        @internal_hash[key] = true
    end

    alias_method :<<, :[]=

    def each
        @internal_hash.each { |k,_| yield k }
    end

    def intersection(other_set)
        other_set.reduce([]) do |array, k|
            array << k if @internal_hash[k]
            array
        end
    end

    def intersect?(other_set)
        # Code Goes Here
    end

    def superset?(other_set)
        # Code Goes Here
    end

    def merge(other_set)
        # Code Goes Here
    end

    def length
        @internal_hash.length
    end

    def ==(other_set)
        other_set.instance_eval { @internal_hash } == @internal_hash ? true : false
    end

    def delete(key)
        @internal_hash.delete(key) ? true : false
    end

    alias_method :pop, :delete

    def subset?(other_set)
        return true if self == other_set
        @internal_hash.keys.each { |k| return false unless other_set.include?(k) }
        true
    end

    def proper_subset?(other_set)
        return false if self == other_set
        return false unless self.subset?(other_set) && self.length < other_set.length
        true
    end

    # def map(&block)
    #     array = []
    #     @internal_hash.each do |k,_|
    #        array << block.call(k)
    #    end
    #    Set.new(array)
    # end


    # def reduce(memo = 0, &block)
    #     @internal_hash.each do |k,_|
    #         memo = block.call(memo, k)
    #     end
    #     memo
    # end  



end

@foo = MySet.new([:a, 12, "string", :baz, :foobar])
@bar = MySet.new([:a, 12, "string", :baz, :foobar])
@baz = MySet.new([:a, 12, "string", :somefoo, [2, 4, 7]])
@qux = MySet.new([:a, 12, "string"])