$LOAD_PATH << File.dirname(__FILE__)

require 'constants'
require 'linked_list'
require 'hash_map'
require 'array'
require 'stack'

require "rspec/autorun"

# ----------------------- Linked List -------------------------
puts "Start Linked List Tests"
ll = LinkedListOfMine.new(40)
ll.push(99)
ll.push(77)
ll.push_to_front(88)
puts ll
puts ll.size
puts ll.pop.data
puts ll.size
puts ll.inspect

describe LinkedListOfMine, ".get_head_node" do 
    it "it returns head_node error" do
        test_ll = LinkedListOfMine.new
        head_node_err = test_ll.get_head_node
        expect(head_node_err).to eq ERROR_EMPTY + ": in get_head_node"
    end
end

describe LinkedListOfMine, ".get_head_node" do 
    it "it returns head_node" do
        test_ll = LinkedListOfMine.new(40)
        test_ll.push(99)
        head_node = test_ll.get_head_node
        expect(head_node.data).to eq 40
        expect(test_ll.size).to eq 2
    end
end

describe LinkedListOfMine, ".get_last_node" do 
    it "it returns last_node error" do
        test_ll = LinkedListOfMine.new
        last_node_err = test_ll.get_last_node
        expect(last_node_err).to eq ERROR_EMPTY + ": in get_last_node"
    end
end

describe LinkedListOfMine, ".get_last_node" do 
    it "it returns last_node" do
        test_ll = LinkedListOfMine.new(40)
        test_ll.push(99)
        last_node = test_ll.get_last_node
        expect(last_node.data).to eq 99
        expect(test_ll.size).to eq 2
    end
end

describe LinkedListOfMine, ".get_penultimate_node" do 
    it "it returns penultimate_node error" do
        test_ll = LinkedListOfMine.new(40)
        penultimate_node_err = test_ll.get_penultimate_node
        expect(penultimate_node_err).to eq ERROR_NOT_ENOUGH_ELEMENTS + ": in get_penultimate_node"
    end
end

describe LinkedListOfMine, ".get_penultimate_node" do 
    it "it returns penultimate_node" do
        test_ll = LinkedListOfMine.new(40)
        test_ll.push(66)
        test_ll.push(70)
        test_ll.push(99)
        penultimate_node = test_ll.get_penultimate_node
        expect(penultimate_node.data).to eq 70
        expect(test_ll.size).to eq 4
    end
end

describe LinkedListOfMine, ".push" do 
    it "it returns push data correctly" do
        test_ll = LinkedListOfMine.new
        test_ll.push(99)
        expect(test_ll.get_head_node.data).to eq 99
        expect(test_ll.size).to eq 1
    end
end

describe LinkedListOfMine, ".push_to_front" do 
    it "it returns push_to_front data correctly" do
        test_ll = LinkedListOfMine.new(40)
        test_ll.push_to_front(99)
        expect(test_ll.get_head_node.data).to eq 99
        expect(test_ll.size).to eq 2
    end
end

describe LinkedListOfMine, ".pop" do 
    it "it returns pop data error" do
        test_ll = LinkedListOfMine.new
        popped_node_err = test_ll.pop
        expect(popped_node_err).to eq ERROR_EMPTY + ": in pop"
    end
end

describe LinkedListOfMine, ".pop" do 
    it "it returns pop data correctly" do
        test_ll = LinkedListOfMine.new(40)
        popped_node = test_ll.pop
        expect(popped_node.data).to eq 40
        expect(test_ll.size).to eq 0
    end
end

describe LinkedListOfMine, ".shift" do 
    it "it returns shift data correctly" do
        test_ll = LinkedListOfMine.new(40)
        test_ll.push(98)
        test_ll.push(99)
        popped_node = test_ll.shift
        expect(popped_node.data).to eq 40
        expect(test_ll.size).to eq 2
    end
end

describe LinkedListOfMine, ".shift" do 
    it "it returns shift data error" do
        test_ll = LinkedListOfMine.new
        popped_node_err = test_ll.shift
        expect(popped_node_err).to eq ERROR_EMPTY + ": in shift"
    end
end

describe LinkedListOfMine, ".clear" do 
    it "it returns correct error and size after clear" do
        test_ll = LinkedListOfMine.new(40)
        test_ll.push(99)
        test_ll.clear()
        expect(test_ll.get_head_node).to eq ERROR_EMPTY + ": in get_head_node"
        expect(test_ll.size).to eq 0
    end
end

describe LinkedListOfMine, ".remove" do 
    it "it returns correct error after remove" do
        test_ll = LinkedListOfMine.new
        result = test_ll.remove(99)
        expect(result).to eq ERROR_EMPTY + ": in remove"
    end
end

describe LinkedListOfMine, ".remove" do 
    it "it returns correct error and size after clear" do
        test_ll = LinkedListOfMine.new("hey")
        test_ll.push("hi")
        test_ll.remove("hey")
        expect(test_ll.size).to eq 1
    end
end

describe LinkedListOfMine, ".remove" do 
    it "it returns correct error and size after clear" do
        test_ll = LinkedListOfMine.new("hey")
        test_ll.push("hi")
        test_ll.push("hello")
        test_ll.remove("hello")
        expect(test_ll.size).to eq 2
    end
end

describe LinkedListOfMine, ".remove" do 
    it "it returns correct error and size after clear" do
        test_ll = LinkedListOfMine.new(7)
        test_ll.push(9)
        test_ll.push(8)
        test_ll.remove(7)
        expect(test_ll.size).to eq 2
    end
end

describe LinkedListOfMine, ".remove" do 
    it "it returns correct error and size after clear" do
        test_ll = LinkedListOfMine.new([7,9])
        hm = HashMapOfMine.new
        hm.add(9, 0)
        test_ll.push(hm)
        test_ll.push(8)
        test_ll.remove([7, 9])
        test_ll.remove(hm)
        expect(test_ll.size).to eq 1
    end
end

describe LinkedListOfMine, ".include?" do 
    it "it returns correct val from include?" do
        test_ll = LinkedListOfMine.new
        test_ll.push("hi")
        test_ll.push("hello")
        test_ll.push("hey")
        result = test_ll.include?("hi")
        expect(result).to eq true
        result = test_ll.include?("hello")
        expect(result).to eq true
        result = test_ll.include?("hey")
        expect(result).to eq true
        result = test_ll.include?("hello3")
        expect(result).to eq false
    end
end

describe LinkedListOfMine, ".inspect" do 
    it "it returns print_list string correctly" do
        test_ll = LinkedListOfMine.new(0)
        for i in (1..5) do 
            test_ll.push(i)
        end
        out_str = test_ll.inspect
        expect(out_str).to eq "\"[ Head: 0 --> 1 --> 2 --> 3 --> 4 --> 5 --> nil ]\""
    end
end

describe LinkedListOfMine, ".inspect" do 
    it "it returns print_list string error" do
        test_ll = LinkedListOfMine.new(0)
        for i in (1..5) do 
            test_ll.push(i)
        end
        test_ll.clear
        out_str_err = test_ll.inspect
        expect(out_str_err).to eq "\"[ Head:  --> nil ]\""
    end
end


# ----------------------- Hash Map -------------------------
puts "\nStart Hash Map Tests"
hm = HashMapOfMine.new(1)
hm.add("hello", "world")
hm.add("foo", "bar")
puts hm.hash(20)
puts hm.inspect
puts hm.get("hello")
hm.get("hi")
hm.remove("hello")
puts hm.inspect
puts hm.size

describe HashMapOfMine, ".add" do 
    it "it adds one record" do
        test_hm = HashMapOfMine.new
        test_hm.add("hello", "world")
        hm_size = test_hm.size
        expect(hm_size).to eq 1
    end
end

describe HashMapOfMine, ".add" do 
    it "it adds two records to starting hash_map of size 1" do
        test_hm = HashMapOfMine.new(1)
        test_hm.add("hello", "world")
        test_hm.add("foo", "bar")
        hm_size = test_hm.size
        expect(hm_size).to eq 2
    end
end

describe HashMapOfMine, ".get" do 
    it "it gets correct error from get" do
        test_hm = HashMapOfMine.new
        result = test_hm.get("hello")
        expect(result).to eq ERROR_EMPTY + ": in get"
    end
end

describe HashMapOfMine, ".get" do 
    it "it gets correct value from key" do
        test_hm = HashMapOfMine.new(1)
        test_hm.add("hello", "world")
        result = test_hm.get("hello")
        expect(result).to eq "world"
    end
end

describe HashMapOfMine, ".get" do 
    it "it gets correct value from key" do
        test_hm = HashMapOfMine.new(1)
        test_hm.add(90, 99)
        test_hm.add(70, 77)
        test_hm.remove(70)
        result = test_hm.get(90)
        expect(result).to eq 99
        result = test_hm.get(70)
        expect(result).to eq nil
    end
end

describe HashMapOfMine, ".get_keys" do 
    it "it gets correct error from get_keys" do
        test_hm = HashMapOfMine.new
        result = test_hm.get_keys()
        expect(result).to eq ERROR_EMPTY + ": in get_keys"
    end
end

describe HashMapOfMine, ".get_keys" do 
    it "it gets correct value from get_keys" do
        test_hm = HashMapOfMine.new
        test_hm.add("hello", "world")
        test_hm.add("foo", "bar")
        result = test_hm.get_keys()
        expect(result.sort).to eq ["hello", "foo"].sort   #TODO update to ArrayOfMine.new([])
    end
end

describe HashMapOfMine, ".get_vals" do 
    it "it gets correct error from get_vals" do
        test_hm = HashMapOfMine.new
        result = test_hm.get_vals()
        expect(result).to eq ERROR_EMPTY + ": in get_vals"
    end
end

describe HashMapOfMine, ".get_vals" do 
    it "it gets correct value from get_vals" do
        test_hm = HashMapOfMine.new
        test_hm.add("hello", "world")
        test_hm.add("foo", "bar")
        result = test_hm.get_vals()
        expect(result.sort).to eq ["world", "bar"].sort   #TODO update to ArrayOfMine.new([])
    end
end

describe HashMapOfMine, ".remove" do 
    it "it gets correct error from remove" do
        test_hm = HashMapOfMine.new
        result = test_hm.remove("hello")
        expect(result).to eq ERROR_EMPTY + ": in remove"
    end
end

describe HashMapOfMine, ".remove" do 
    it "it deletes one record" do
        test_hm = HashMapOfMine.new(1)
        test_hm.add("hello", "world")
        test_hm.remove("hello")
        hm_size = test_hm.size
        expect(hm_size).to eq 0
    end
end

describe HashMapOfMine, ".include?" do 
    it "it returns correct val from include?" do
        test_hm = HashMapOfMine.new
        test_hm.add("hi", "world")
        test_hm.add("hello", "world")
        test_hm.add("hey", "world")
        result = test_hm.include?("hi")
        expect(result).to eq true
        result = test_hm.include?("hello")
        expect(result).to eq true
        result = test_hm.include?("hey")
        expect(result).to eq true
        result = test_hm.include?("hello3")
        expect(result).to eq false
    end
end

describe HashMapOfMine, ".inspect" do 
    it "it prints hash_map with one record" do
        test_hm = HashMapOfMine.new(1)
        test_hm.add("hello", "world")
        print_str = test_hm.inspect
        expect(print_str).to eq "\"{hello => world}\""
    end
end

# ----------------------- Array -------------------------
puts "\nStart Array Tests"
arr = ArrayOfMine.new


# ----------------------- Stack -------------------------



# ----------------------- ??? -------------------------
