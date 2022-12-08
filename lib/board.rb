require 'rspec'
require './lib/ship'
require './lib/cell'

class Board
    attr_reader :cells_hash

    def initialize
        @cells_hash = Hash.new(0)
    end

    def cells
        @cells_hash = {
            "A1" => Cell.new("A1"),
            "A2" => Cell.new("A2"),
            "A3" => Cell.new("A3"),
            "A4" => Cell.new("A4"),
            "B1" => Cell.new("B1"),
            "B2" => Cell.new("B2"),
            "B3" => Cell.new("B3"),
            "B4" => Cell.new("B4"),
            "C1" => Cell.new("C1"),
            "C2" => Cell.new("C2"),
            "C3" => Cell.new("C3"),
            "C4" => Cell.new("C4"),
            "D1" => Cell.new("D1"),
            "D2" => Cell.new("D2"),
            "D3" => Cell.new("D3"),
            "D4" => Cell.new("D4")
        }
    end

    def valid_coordinate?(coordinate)
        @cells_hash.keys.include?(coordinate)
    end

    def valid_placement?(ship, coord_array)
        number_check = []
        letter_check = []
        coord_array.each do |coord_element|
            coord_element.chars
            if coord_element.chars.length == 2
               number_check << coord_element.chars[1].to_i
            end

        end
        coord_array.each do |coord_element|
            coord_element.chars
            if coord_element.chars.length == 2
               letter_check << coord_element.chars[0]
            end

        end
        coord_array.each do |coord_element|
            coord_element.chars
            
            ship.length.times do |i|
                if (number_check[i + 1].to_i - number_check[i].to_i) != 1 && letter_check[i] == letter_check[i + 1]
                     # require 'pry'; binding.pry
                    return false
                    break
                end
            end

            ship.length.times do |i|
                if  letter_check[i + 1] == nil
                    # require 'pry'; binding.pry
                    break
                elsif (letter_check[i + 1].ord - letter_check[i].ord) != 1 
                     # require 'pry'; binding.pry
                    return false
                    break
                end
            end

            if coord_element.chars[0].ord >= 69
                  # require 'pry'; binding.pry
                return false 
            elsif coord_element.chars[1].to_i < 0 || coord_element.chars[1].to_i > 5
                  # require 'pry'; binding.pry
                return false
            # elsif coord_element.chars.length != ship.length 
            #       # require 'pry'; binding.pry
            #     return false
            elsif coord_array.length != ship.length 
                  # require 'pry'; binding.pry
                return false
             
            elsif number_check.last > number_check.first
                  # require 'pry'; binding.pry
                return false
            elsif letter_check.first.ord > letter_check.last.ord
                  # require 'pry'; binding.pry
                return false
            else
                  # require 'pry'; binding.pry
                return true
                
            end
        end
    end
end