require 'rspec'
require './lib/ship'
require './lib/cell'

class Variable_Board
    attr_accessor   :height,
                    :width,
                    :cells_hash

    def initialize(width, height)
        @width = width
        @height = height
        @cells_hash = cells
    end

    def cells
        width_array = []
        height_array = []
        cell_array = []

        @width.downto(1) {|i| width_array.unshift(i)}

        @height.upcase.ord.downto(65) {|i| height_array.unshift(i.chr)}

        height_array.each do |letter|
            width_array.each do |number|
                cell_array << "#{letter}#{number}"
            end
        end
        
        @cells ||= Hash[cell_array.collect { |element| [element, Cell.new(element)] }]
    end

    def valid_coordinate?(coordinate)
        @cells_hash.keys.include?(coordinate)
    end

    def valid_placement?(ship, coord_array)
        number_check = []
        letter_check = []

        if coord_array.length != ship.length 
            return false
        end

        coord_array.each do |coord_element|
            if valid_coordinate?(coord_element) == false
                return false
            end

            if cells_hash[coord_element].empty? == false
                return false
            end

            if coord_element.chars.length == 2
                letter_check << coord_element.chars[0]
                number_check << coord_element.chars[1].to_i
            elsif coord_element.chars.length == 3
                letter_check << coord_element.chars[0]
                number_check << "#{coord_element.chars[1]}#{coord_element.chars[2]}".to_i
            elsif coord_element.chars.length == 4
                letter_check << coord_element.chars[0]
                number_check << "#{coord_element.chars[1]}#{coord_element.chars[2]}#{coord_element.chars[3]}".to_i
            else
                return false
            end

        end

        if ship.length == 3
            if letter_check[0] == letter_check[1] && letter_check[0] != letter_check[2]
                if number_check[0] == number_check[1] || number_check[0] == number_check[2]
                    return false
                end
            elsif letter_check[0] != letter_check[1] && letter_check[0] != letter_check[2]
                if number_check[0] != number_check[1] || number_check[0] != number_check[2]
                    return false
                end
            end

            if letter_check[0] != letter_check[1]
                if number_check[0] != number_check[1] && number_check[0] != number_check[2]
                    return false
                end
            elsif letter_check[0] != letter_check [2]
                if number_check[0] != number_check[1] && number_check[0] != number_check[2]
                    return false
                end
            end

            if letter_check[1] != letter_check[2] && letter_check[0] == letter_check[2]
                return false
            end
        elsif ship.length == 2
            if letter_check[0] != letter_check[1] && number_check[0] != number_check[1]
                return false
            end
        end

        ship.length.times do |index_loc|
            if letter_check[index_loc].ord >= 91
                return false
            elsif number_check[index_loc] < 0 || number_check [index_loc] > @width
                return false
            elsif  number_check[index_loc + 1] == nil
                break
            elsif  letter_check[index_loc + 1] == nil
                break
            elsif (number_check[index_loc + 1] - number_check[index_loc]) != 1 && letter_check[index_loc] == letter_check[index_loc + 1]
                return false
            elsif (number_check[index_loc + 1] - number_check[index_loc]) != 1 && letter_check[index_loc + 1].ord - letter_check[index_loc].ord != 1
                return false
            elsif (letter_check[index_loc + 1].ord - letter_check[index_loc].ord) != 1 && (number_check[index_loc + 1] - number_check[index_loc]) != 1
                return false
            elsif (letter_check[index_loc + 1].ord - letter_check[index_loc].ord) == 1 && (number_check[index_loc + 1] - number_check[index_loc]) == 1
                return false
            end
        end

        return true
    end

    def place(ship, coords)
        if valid_placement?(ship, coords)
            ship.length.times do |ship_length|
                cells_hash[coords[ship_length]].place_ship(ship)
            end
        end
        cells_hash
    end

    def check_for_s(coord)
        # require 'pry'; binding.pry
        if coord.render == "." && coord.empty? == false
            return "S"
        else
            return coord.render
        end
    end

    def render(check)
        width_array = []
        height_array = []
        cell_array = []
        render_loop = []
        render_loop_true = []

        @width.downto(1) {|i| width_array.unshift(i)}

        @height.upcase.ord.downto(65) {|i| height_array.unshift(i.chr)}

        height_array.each do |letter|
            render_loop << "#{letter}"
            width_array.each do |number|
                render_loop << " #{cells_hash["#{letter}#{number}"].render}"
            end
            render_loop << " \n"
        end

        height_array.each do |letter|
            render_loop_true << "#{letter}"
            width_array.each do |number|
                render_loop_true << " #{check_for_s(cells_hash["#{letter}#{number}"])}"
            end
            render_loop_true << " \n"
        end

        if check == false
            return "  #{width_array.join(" ")} \n#{render_loop.join}"
        elsif check == true
            return "  #{width_array.join(" ")} \n#{render_loop_true.join}"
        end
    end
end