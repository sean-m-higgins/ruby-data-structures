$LOAD_PATH << File.dirname(__FILE__)

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

    #// TODO add fix to make test pass... resize map upon addition that exceeds the size
    def add(key, value)
        return val if include?(key)
        
        if @size == @n_buckets
            resize()
            add(key, value)
        else
            bucket = get_bucket_for_key(key)
            # result = check_bucket_for_key(key, bucket)
            # key_exists = result[0]
            # if key_exists
            #     bucket[result[1]] = [key, value]
            # else
            #     bucket.push([key, value])
            # end
            bucket.push([key, value])
            set_size(@size + 1)
        end

        value
    end

    alias :[]= :add

    # // TODO make private??
    def get_bucket_for_key(key)
        if @n_buckets == 0
            puts "error : no elements in hash_map to get"
        end
        hashed = hash(key)
        bucket = @hash_map.at(hashed)
        return bucket
    end

    def check_bucket_for_key(key, bucket)
        found_key = false
        i = 0
        if bucket.size > 0
            bucket.each do |record| 
                r_key = record.data[0]
                if r_key == key
                    found_key = true
                    break
                end
                i += 1
            end
        end
        return [found_key, i]
    end

    def get(key)
        if @size == 0
            puts "error : no elements to get"
        end
        bucket = get_bucket_for_key(key)
        value = nil
        result = check_bucket_for_key(key, bucket)
        key_exists = result[0]
        if key_exists
            bucket.each do |record|
                temp_key = record.data[0]
                if key == temp_key
                    return record.data[1]
                end
            end
        else
            puts "no record found for key: " + key.to_s
            return nil
        end
    end

    def delete(key)
        if @size == 0
            puts "error : no elements to get"
        end
        bucket = get_bucket_for_key(key)
        result = check_bucket_for_key(key, bucket)
        key_exists = result[0]
        puts "hiii"
        puts result[1]
        if key_exists
            cur_node = bucket.get_head_node()
            if result[1] == 0
                hashed = hash(key)
                puts bucket.size.to_s
                if bucket.size == 1
                    @hash_map[hashed] = LinkedListOfMine.new
                else
                    node_to_be_removed = cur_node
                    puts node_to_be_removed.data
                    cur_node = node_to_be_removed.next_node
                    puts cur_node.data
                    t = bucket.get_head_node()
                    puts t.data
                    @hash_map[hashed] = bucket
                end
            else
                i = 0
                while cur_node != nil
                    if i == result[1] - 1
                        break
                    elseif i == result[1]
                        puts "FAILURE"
                    end
                    i += 1
                    cur_node = cur_node.next_node
                end
                node_to_be_removed = cur_node.next_node
                cur_node.next_node = node_to_be_removed.next_node
            end
            set_size(@size - 1)
        else
            puts "no record found for key: " + key.to_s
        end
    end

    def print_hash_map
        print_str = ""
        print_str += "{\n"
        indent = "  "
        first = true
        @hash_map.each do |bucket|
            temp_print_str = "" 
            bucket.each do  |record|
                if !first
                    temp_print_str = temp_print_str + ",\n"
                else
                    first = false
                end
                r_key = record.data[0]
                r_val = record.data[1]
                temp_print_str += indent + r_key.to_s + ":" + indent + r_val.to_s
            end
            print_str += temp_print_str
        end
        print_str += "\n}"
        return print_str
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

    def resize
        if @size == 0
            puts "error : no elements to resize"
        end
        temp_size = @size
        temp_size = temp_size*2
        set_n_buckets(temp_size)
        temp_hash_map = create_buckets()
        @hash_map.each do |bucket|
            bucket.each do  |record|
                key = record.data[0]
                value = record.data[1]
                index = hash(key)
                bucket = temp_hash_map.at(index)
                result = check_bucket_for_key(key, bucket)
                key_exists = result[0]
                if key_exists
                    bucket[result[1]] = [key, value]
                else
                    bucket.push([key, value])
                end 
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
    
    def include?(key)
        index = hash(key)
        bucket = @hash_map.at(index)
        bucket.include?(key)
    end

    # //TODO 
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