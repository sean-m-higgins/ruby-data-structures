$LOAD_PATH << File.dirname(__FILE__)

require 'constants'
require 'array'
require 'linked_list'

class HashMapOfMine
    include Enumerable

    attr_accessor :buckets, :size, :n_buckets
    
    def initialize(size=nil, items=[])
        set_n_buckets(5)
        set_size(0)
        if size != nil
            set_n_buckets(size)
        end
        @hash_map = create_buckets()
        
        unless items.empty?
            items.each do |record|
                key = record[0]
                val = record[1]
                add(key, val)
            end
        end
    end

    def empty? 
        if @size == 0
            return true
        elsif check_size == 0
            return true
        else
            return false
        end
    end

    def create_buckets
        buckets = []    # //TODO change to ArrayOfMine.new(@n_buckets)
        for i in (1..@n_buckets)
            buckets.append(LinkedListOfMine.new)
        end
        buckets
    end

    def hash(key)
        return key.hash % @n_buckets
    end
    
    def get_bucket_for_key(key)
        hashed = hash(key)
        bucket = @hash_map.at(hashed)
        return bucket
    end

    def add(key, value)
        return value if include?(key)
        
        if @size == @n_buckets
            resize()
            add(key, value)
        else
            bucket = get_bucket_for_key(key)
            bucket.push([key, value])
            set_size(@size + 1)
        end

        value
    end

    alias :[]= :add

    def get(key)
        if empty?
            return ERROR_EMPTY + ": in get"
        end
        index = hash(key)
        bucket = @hash_map.at(index)
        bucket.each do |record|
            return record.data[1] if record.data[0] == key
        end
    end

    def get_keys
        if empty?
            return ERROR_EMPTY + ": in get_keys"
        end
        keys = []   #TODO update to ArrayOfMine.new
        @hash_map.each do |bucket|
            bucket.each do  |record|
                keys.append(record.data[0])
            end
        end
        keys
    end

    def get_vals
        if empty?
            return ERROR_EMPTY + ": in get_vals"
        end
        vals = []   #TODO update to ArrayOfMine.new
        @hash_map.each do |bucket|
            bucket.each do  |record|
                vals.append(record.data[1])
            end
        end
        vals
    end

    def remove(key)
        if empty?
            return ERROR_EMPTY + ": in remove"
        end
        index = hash(key)
        bucket = @hash_map.at(index)
        if bucket.include?(key)
            bucket.remove(key)
            set_size(@size - 1)
        end
    end

    def resize
        set_n_buckets(@n_buckets*2)
        temp_hash_map = create_buckets()
        @hash_map.each do |bucket|
            bucket.each do  |record|
                key = record.data[0]
                value = record.data[1]
                index = hash(key)
                bucket = temp_hash_map.at(index)
                bucket.push([key, value])
            end
        end
        @hash_map = temp_hash_map
    end

    def set_n_buckets(size)
        @n_buckets = size
    end

    def set_size(size)
        @size = size
    end

    def check_size
        size = 0
        @hash_map.each do |bucket|
            bucket.each do  |record|
                size += 1
            end
        end
        return size
    end
    
    def include?(key)
        index = hash(key)
        bucket = @hash_map.at(index)
        bucket.include?(key)
    end

    def each(&block)
        @hash_map.each do |bucket|
            bucket.each do  |record|
                block.call(record.data[0], record.data[1])
            end
        end
    end

    def inspect
        records = map { |key, val| "#{key} => #{val}"}.join(", ")
        "{#{records}}".inspect
    end

end