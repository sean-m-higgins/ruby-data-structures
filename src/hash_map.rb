$LOAD_PATH << File.dirname(__FILE__)

class HashMapOfMine

    def initialize(size=nil)
        @size = 0
        if size != nil
            @size = size
            @hash_map = create_buckets()
        end
    end

    def create_buckets
        if @size == 0
            puts "error : no elements to create buckets"
        end
        buckets = []
        for i in (0..@size)
            buckets.append([])
        end
        return buckets
    end

    def hash(key)
        if @size == 0
            puts "error : no elements in hash_map to hash"
        end
        return key.hash % @size
    end

    def add(key, value)
        if @size == 0
            @size = 1
            @hash_map = create_buckets()
        end
        hashed = hash(key)
        bucket = @hash_map.at(hashed)
        result = check_bucket_for_key(key, bucket)
        key_exists = result[0]
        if key_exists
            bucket[result[1]] = [key, value]
        else
            bucket.append([key, value])
        end
    end

    def check_bucket_for_key(key, bucket)
        found_key = false
        i = 0
        if bucket.length > 0
            bucket.each do  |record| 
                r_key = record[0]
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
        hashed = hash(key)
        bucket = @hash_map.at(hashed)
        value = nil
        result = check_bucket_for_key(key, bucket)
        key_exists = result[0]
        if key_exists
            record = bucket[result[1]]
            return record[1]
        else
            puts "no record found for key: " + key.to_s
            return nil
        end
    end

    def delete(key)
        if @size == 0
            puts "error : no elements to get"
        end
        hashed = hash(key)
        bucket = @hash_map.at(hashed)
        result = check_bucket_for_key(key, bucket)
        key_exists = result[0]
        if key_exists
            bucket.delete_at(result[1])
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
                r_key = record[0]
                r_val = record[1]
                temp_print_str += indent + r_key.to_s + ":" + indent + r_val.to_s
            end
            print_str += temp_print_str
        end
        print_str += "\n}"
        return print_str
    end

end