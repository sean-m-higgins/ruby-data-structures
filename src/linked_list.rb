$LOAD_PATH << File.dirname(__FILE__)

require 'node'

class LinkedListOfMine

    def initialize(data=nil)
        if data != nil
            push(data)
        end
    end

    def is_empty? 
        if @head == nil
            return true
        else
            return false
        end
    end

    def get_head_node
        if is_empty?
            return "error: not enough elements"
        end
        return @head
    end

    def get_last_node
        if is_empty?
            return "error: not enough elements"
        end
        cur_node = @head
        while cur_node.next_node != nil
            cur_node = cur_node.next_node
        end
        return cur_node
    end

    def get_penultimate_node
        if size < 2
            return "error: not enough elements"
        end
        cur_node = @head
        while cur_node.next_node.next_node != nil
            cur_node = cur_node.next_node
        end
        return cur_node
    end

    def push(something)
        if is_empty?
            @head = NodeOfMine.new(something)
        else
            new_node = NodeOfMine.new(something)
            last_node = get_last_node
            last_node.next_node = new_node
        end
    end

    def push_to_front(something)
        if is_empty?
            @head = NodeOfMine.new(something)
        else
            prev_head_node = @head
            new_node = NodeOfMine.new(something, prev_head_node)
            @head = new_node
        end
    end

    def pop
        if is_empty?
            return "error: empty list"
        end
        if size == 1
            last_node = @head
            @head = nil
            return last_node
        else
            penultimate_node = get_penultimate_node
            last_node = penultimate_node.next_node
            penultimate_node.next_node = nil
            return last_node
        end
    end

    def shift
        if is_empty?
            return "error: empty list"
        end
        if size == 1
            last_node = @head
            @head = nil
            return last_node
        else
            prev_head_node = @head
            @head = prev_head_node.next_node
            return prev_head_node
        end
    end

    def clear 
        @head = nil
    end
    
    def size
        counter = 0
        cur_node = @head
        while cur_node != nil
            counter += 1
            cur_node = cur_node.next_node
        end
        return counter
    end

    def print_list
        print_str = ""
        if is_empty?
            return "error: empty list"
        end
        cur_node = @head
        counter = 0
        while cur_node != nil
            if counter == 0
                print_str += "[ Head "  + counter.to_s + ": " + cur_node.data.to_s
            else 
                print_str += " --> Node " + counter.to_s + ": " + cur_node.data.to_s
            end
            counter += 1
            cur_node = cur_node.next_node
        end
        print_str += " --> nil ]"
        return print_str
    end

    # //TODO 
    def each(&block)
        cur_node = @head
        while cur_node != nil
            yield cur_node
            cur_node = cur_node.next_node
        end
    end
    
end