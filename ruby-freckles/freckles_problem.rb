#encoding: UTF-8
class FrecklesProblem
    require './freckles_field'
    require './freckle'


    def initialize(filepath)
        @filename = filepath
        read_file
        puts "Número de casos encontrados: #{@fields.size}"
        @fields.each do |field|
            field.solve
        end
    end
    
    private
    
    def read_file
    @fields = []
        file = File.new(@filename)
        num_fields = file.gets.to_i
        num_fields.times do |i|
            file.gets
            field = FrecklesField.new
            num_points = file.gets.to_i
            num_points.times do |j|
                line = file.gets
                numbers = line.split(",").collect {|number| number.to_f }
                field.freckles << Freckle.new(numbers.first, numbers.last)
            end
            @fields << field
        end
    end
end

FrecklesProblem.new("teste.txt")
