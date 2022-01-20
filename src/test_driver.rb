$LOAD_PATH << File.dirname(__FILE__)

require 'linked_list'

require "rspec/autorun"

# ----------------------- Linked Lists -------------------------
ll = LinkedListOfMine.new(40)
ll.push(99)
ll.push(77)
ll.push_to_front(88)
puts ll
puts ll.size
puts ll.pop.data
puts ll.size

puts ll.print_list

describe LinkedListOfMine, ".get_last_node" do 
    it "it returns last_node error" do
        test_ll = LinkedListOfMine.new
        last_node_err = test_ll.get_last_node
        expect(last_node_err).to eq "error: not enough elements"
    end
end

describe LinkedListOfMine, ".get_penultimate_node" do 
    it "it returns penultimate_node error" do
        test_ll = LinkedListOfMine.new(40)
        last_node_err = test_ll.get_penultimate_node
        expect(last_node_err).to eq "error: not enough elements"
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
    it "it returns pop data correctly" do
        test_ll = LinkedListOfMine.new(40)
        popped_node = test_ll.pop
        expect(popped_node.data).to eq 40
        expect(test_ll.size).to eq 0
    end
end

describe LinkedListOfMine, ".pop" do 
    it "it returns pop data error" do
        test_ll = LinkedListOfMine.new
        popped_node_err = test_ll.pop
        expect(popped_node_err).to eq "error: empty list"
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
        expect(popped_node_err).to eq "error: empty list"
    end
end

describe LinkedListOfMine, ".print_list" do 
    it "it returns print_list string correctly" do
        test_ll = LinkedListOfMine.new(0)
        for i in (1..5) do 
            test_ll.push(i)
        end
        out_str = test_ll.print_list
        expect(out_str).to eq "[ Head 0: 0 --> Node 1: 1 --> Node 2: 2 --> Node 3: 3 --> Node 4: 4 --> Node 5: 5 --> nil ]"
    end
end

describe LinkedListOfMine, ".print_list" do 
    it "it returns print_list string error" do
        test_ll = LinkedListOfMine.new(0)
        for i in (1..5) do 
            test_ll.push(i)
        end
        test_ll.clear
        out_str_err = test_ll.print_list
        expect(out_str_err).to eq "error: empty list"
    end
end


# ----------------------- ??? -------------------------