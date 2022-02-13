$LOAD_PATH << File.dirname(__FILE__)

class ArrayOfMine
    include Enumerable

    attr_accessor :data, :length

    def initialize(items=[], length=nil)
        if length != nil
            @data = HashMapOfMine.new(length)
        else
            @data = HashMapOfMine.new
        end

        set_length(0)
        items.each do |elem|
            append(elem)
        end
    end

    def empty?
        return true if @length <= 0
        return false
    end

    def append(something)
        @data.add(@length, something)
        set_length(@length + 1)
        return @data
    end

    # remove from back
    def pop
        if empty?
            return ERROR_EMPTY + ": in pop"
        end
        return remove_at(@length - 1)
    end

    # remove from front
    def shift
        if empty?
            return ERROR_EMPTY + ": in shift"
        end
        return remove_at(0)
    end

    def at(index)
        if empty?
            return ERROR_EMPTY + ": in at"
        end
        return @data.get(index)
    end

    def insert(index, something)
        if index > @length
            return ERROR_OUT_OF_INDEX_RANGE + ": in insert"
        end
        update_indices_insert(index)
        @data.add(index, something)
        set_length(@length + 1)
    end

    def clear
        @data = HashMapOfMine.new
        set_length(0)
    end

    def remove_at(index)
        if empty?
            return ERROR_EMPTY + ": in remove_at"
        end
        elem = @data.get(index)
        @data.remove(index)
        update_indices_remove(index)
        set_length(@length - 1)
        return elem
    end

    def remove(something)
        if empty?
            return ERROR_EMPTY + ": in remove"
        end
        index = nil
        if include?(something)
            index = get_index(something)
        end
        if index != nil
            return remove_at(index)
        else
            return ERROR_NOT_FOUND + ": in remove"
        end
    end

    def update_indices_remove(index)
        (index..@length).each do |new_i_key|
            old_i_key = new_i_key + 1
            val = @data.get(old_i_key)
            @data.add(new_i_key, val)
        end
    end

    def update_indices_insert(index)
        (index..@length).reverse_each do |new_i_key|
            old_i_key = new_i_key - 1
            val = @data.get(old_i_key)
            @data.add(new_i_key, val)
        end
    end

    def set_length(len)
        @length = len
    end

    # TODO have method just for index? for index and value??
    def include?(something)
        index = nil
        if include?(something)
            index = get_index(something)
        end
        if index != nil
            @
        else
            return ERROR_NOT_FOUND + ": in remove"
        end

        false
    end

    def each(&block)
        @data.each do |elem|
            block.call(elem)
        end
    end

    def inspect
        records = map { |index, elem| "#{elem}" }.join(", ")
        "[ #{records} ]".inspect
    end

end