$LOAD_PATH << File.dirname(__FILE__)

class ArrayOfMine
    include Enumerable

    attr_accessor :arr, :length

    def initialize(items=[], length=nil)
        if length != nil
            @arr = HashMapOfMine.new(length)
        else
            @arr = HashMapOfMine.new
        end

        set_length(0)
        items.each do |elem|
            append(elem)
        end
    end

    def empty?
        return true if @length == 0
        return false
    end

    def append(something)
        @arr.add(@length, something)
        set_length(@length + 1)
        return @arr
    end

    # remove from back
    def pop
        if empty?
            return ERROR_EMPTY + ": in pop"
        end
        set_length(@length - 1)
        return remove_at(@length)
    end

    # remove from front
    def shift
        if empty?
            return ERROR_EMPTY + ": in shift"
        end
        set_length(@length - 1)
        return remove_at(0)
    end

    def at(index)
        if empty?
            return ERROR_EMPTY + ": in at"
        end
        return @arr.get(index)
    end

    def insert(index, something)
        if index > @length
            return ERROR_OUT_OF_INDEX_RANGE + ": in insert"
        end

    end

    def clear
        @arr = HashMapOfMine.new
        set_length(0)
    end

    def remove_at(index)
        if empty?
            return ERROR_EMPTY + ": in remove_at"
        end
        elem = @arr.at(index)
        remove(elem)
        return elem
    end

    def remove(something)
        if empty?
            return ERROR_EMPTY + ": in remove"
        end
        if include?(something)
            index = get_index(something)
            update_indices(index)
        end
        @arr.remove(something)
        return something
    end

    def update_indices(index)

    end

    def set_length(len)
        @length = len
    end

    def include?(something)
    
    end

    def each(&block)
        @arr.each do |elem|
            block.call(elem)
        end
    end

    def inspect
        records = map { |index, elem| "#{elem}" }.join(", ")
        "[ #{records} ]".inspect
    end

end