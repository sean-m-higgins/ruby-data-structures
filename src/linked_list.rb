$LOAD_PATH << File.dirname(__FILE__)

require 'constants'
require 'node'

class LinkedListOfMine
    include Enumerable

    attr_accessor :head

    def initialize(data=nil)
        if data != nil
            push(data)
        end
    end

    def empty? 
        return true if @head == nil
        return false
    end

    # def get_head_node
    #     if empty?
    #         return ERROR_EMPTY + ": in get_head_node"
    #     end
    #     return @head
    # end

    def get_last_node
        if empty?
            return ERROR_EMPTY + ": in get_last_node"
        end
        cur_node = @head
        while cur_node.next_node != nil
            cur_node = cur_node.next_node
        end
        return cur_node
    end

    def get_penultimate_node
        if size < 2
            return ERROR_NOT_ENOUGH_ELEMENTS + ": in get_penultimate_node"
        end
        cur_node = @head
        while cur_node.next_node.next_node != nil
            cur_node = cur_node.next_node
        end
        return cur_node
    end

    def push(something)
        if empty?
            @head = NodeOfMine.new(something)
        else
            new_node = NodeOfMine.new(something)
            last_node = get_last_node
            last_node.next_node = new_node
        end
    end

    def push_to_front(something)
        if empty?
            @head = NodeOfMine.new(something)
        else
            prev_head_node = @head
            new_node = NodeOfMine.new(something, prev_head_node)
            @head = new_node
        end
    end

    def pop
        if empty?
            return ERROR_EMPTY + ": in pop"
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
        if empty?
            return ERROR_EMPTY + ": in shift"
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

    def remove(something)
        if empty?
            return ERROR_EMPTY + ": in remove"
        end
        cur_node = @head
        if cur_node.include?(something)
            @head = cur_node.next_node
        else
            while cur_node.next_node != nil
                if cur_node.next_node.include?(something)
                    cur_node.next_node = cur_node.next_node.next_node
                    break
                end
                cur_node = cur_node.next_node
            end
        end
    end

    def include?(something)
        cur_node = @head
        while cur_node != nil
            return true if cur_node.include?(something)
            cur_node = cur_node.next_node
        end
        false
    end

    # //TODO check
    def each(&block)
        cur_node = @head
        while cur_node != nil
            yield cur_node
            cur_node = cur_node.next_node
        end
    end

    def inspect
        records = map { |node| "#{node.data}" }.join(" --> ")
        "[ Head: #{records} --> nil ]".inspect
    end
    
end