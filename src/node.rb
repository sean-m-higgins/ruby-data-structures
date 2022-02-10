

class NodeOfMine

    attr_accessor :data, :next_node

    def initialize(data, next_node=nil)
        @data = data
        @next_node = next_node
    end

    def include?(something)
        @data.include?(something)
    end

end