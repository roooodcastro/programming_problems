#encoding: UTF-8
class Freckle

    attr_accessor :x, :y, :connections
    
    def initialize(x, y)
        @x = x.to_f
        @y = y.to_f
        @connections = []
    end
    
    def distance_to(freckle2)
        diff_x = (freckle2.x - @x).abs
        diff_y = (freckle2.y - @y).abs
        return Math.sqrt(diff_x ** 2 + diff_y ** 2)
    end
    
    def has_connection_to?(freckle2, visited=[])
        (@connections - visited).each do |connection|
            return true if connection == freckle2
            visited << self
            return true if connection.has_connection_to?(freckle2, visited)
        end
        false
    end
    
    def to_s
        "{#{x}, #{y}}"
    end
    
    def ==(freckle2)
        @x == freckle2.x and @y == freckle2.y
    end
end
