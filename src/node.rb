$LOAD_PATH << File.dirname(__FILE__)

class NodeOfMine

    attr_accessor :data, :next_node

    def initialize(data, next_node=nil)
        @data = data
        @next_node = next_node
    end

    def include?(something)
        def include_?(som, orig_som)
            return true if som == orig_som
            if som.respond_to?(:each)
                som.each do |item|
                    return true if include_?(item, orig_som)
                end
                return false
            elsif som.is_a?(NodeOfMine)
                return true if include_?(som.data, orig_som)
            else
                return false
            end
        end

        if @data.respond_to?(:each)
            return include_?(@data, something)
        elsif @data.respond_to?(:include?)
            return @data.include?(something)
        else
            puts "suc"
            return include_?(@data, something)
        end

        return false
    end
    
end