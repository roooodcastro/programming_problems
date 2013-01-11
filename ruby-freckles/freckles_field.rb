#encoding: UTF-8
class FrecklesField

    attr_reader :path_size, :freckles

    def initialize
        @path_size = 0
        @freckles = []
    end
    
    def has_loose_ends?
        freckles.combination(2).each do |freckle1, freckle2|
            return true unless freckle1.has_connection_to? freckle2
        end
        false
    end
    
    def connect(freckle1, freckle2)
        freckle1.connections << freckle2
        freckle2.connections << freckle1
        @path_size += freckle1.distance_to freckle2
    end
    
    def solve
        puts "\nResolvendo um caso com #{freckles.size} freckles"
        while has_loose_ends?
            distances = []
            freckles.combination(2).each do |freckle1, freckle2|
                distances << Distance.new(freckle1, freckle2)
            end
            distances.delete_if { |distance| distance.is_already_connected? }
            min_distance = distances.min
            connect(min_distance.freckle1, min_distance.freckle2)
            puts "Conectando #{min_distance.freckle1} a #{min_distance.freckle2}"
        end
        puts "Distância mínima encontrada: #{@path_size}"
    end
    
    class Distance
        include Comparable
    
        attr_reader :value, :freckle1, :freckle2
        
        def initialize(freckle1, freckle2)
            @freckle1 = freckle1
            @freckle2 = freckle2
            @value = freckle1.distance_to freckle2
        end
        
        def <=>(distance2)
            @value <=> distance2.value
        end
        
        def is_already_connected?
            freckle1.has_connection_to? freckle2
        end
    end
end
