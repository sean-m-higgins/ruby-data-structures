$LOAD_PATH << File.dirname(__FILE__)

require 'array'
require 'linked_list'

class HashMapOfMine

    attr_accessor :buckets, :size, :map_size, :num_buckets
    
    def initialize(size=nil)
        set_map_size(0)
        set_size(0)
        if map_size != nil
            set_map_size(size)
            @hash_map = create_buckets()
        end
    end

    def create_buckets
        if @map_size == 0
            puts "error : no elements to create buckets"
        end
        buckets = []
        for i in (1..@map_size)
            buckets.append(LinkedListOfMine.new)
        end
        return buckets
    end

    def hash(key)
        return key.hash % @map_size
    end

    #// TODO add fix to make test pass... resize map upon addition that exceeds the size
    def add(key, value)
        if @size == 0
            set_map_size(1)
            @hash_map = create_buckets()
        end
        if @size == @map_size
            resize()
        end
        bucket = get_bucket_for_key(key)
        result = check_bucket_for_key(key, bucket)
        key_exists = result[0]
        if key_exists
            bucket[result[1]] = [key, value]
        else
            bucket.push([key, value])
        end
        set_size(@size + 1)
    end

    # // TODO make private??
    def get_bucket_for_key(key)
        if @map_size == 0
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
        set_map_size(temp_size)
        temp_hash_map = create_buckets()
        @hash_map.each do |bucket|
            bucket.each do  |record|
                key = record.data[0]
                value = record.data[1]
                hashed = hash(key)
                bucket = temp_hash_map.at(hashed)
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

    def set_map_size(size)
        @map_size = size
    end

    def set_size(size)
        @size = size
    end
    
    # //TODO 
    def include?()

    end

    # //TODO 
    def each(&block)
        @hash_map.each do |bucket|
            bucket.each do  |record|
                block.call(record.data[0], record.data[1])
            end
        end
    end

    # //TODO 
    def inspect

    end

end