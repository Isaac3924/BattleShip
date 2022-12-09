require 'rspec'
require './lib/ship'
require './lib/cell'

class Board
    attr_reader :cells_hash

    def initialize #The board starts with a attribute cells_hash as a new empty Hash.
        @cells_hash = Hash.new(0)
    end

    def cells #The cells method sets the attribute cells_hash to be has of A1-D4 of instances of Cells that have a String as the coordinate attribute and nil for ship.
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

    def valid_coordinate?(coordinate) #The method looks through an array of Hash keys, Strings of A1-D4, and will return true if that array contains the coordinate argument.
        @cells_hash.keys.include?(coordinate)
    end

    def valid_placement?(ship, coord_array) #The method takes a instance of Ship, and an array of TWO CHARACTER Strings.
        number_check = []
        letter_check = []

        if coord_array.length != ship.length 
            return false
        end

        coord_array.each do |coord_element| #["A1", "A2"].each do |"A1" (THEN) "A2" (ETC)|
            #require "pry"; binding.pry
            if valid_coordinate?(coord_element) == false
                return false
            end

            # coord_element.chars ["A", "1"] THEN ["A", "2"]
            if coord_element.chars.length == 2 #Is ther onely two elements in ["A", "1"]?
                letter_check << coord_element.chars[0]
                number_check << coord_element.chars[1].to_i #["A", "1"](1) = "1".to_i Changes the "1" String to an int of 1. And then pushes it into the Number Check Array.
            else
                return false
            end

        end

        #Example used Line 40 of board_spec:
        ship.length.times do |index_loc| #(cruiser.length == 3).times do |index_loc == 0 (FIRST, THEN GOES UP BY ONE IF IT REACHES THE END AND LOOPS AGAIN UNTIL IT REACHES 3)|
            if letter_check[index_loc].ord >= 69 
                return false
            elsif number_check[index_loc] < 0 || number_check [index_loc]> 5
                #require 'pry'; binding.pry
                return false
            elsif  number_check[index_loc + 1] == nil #Logic to catch the error of comparing a nil value.
                #require 'pry'; binding.pry
                break
            elsif  letter_check[index_loc + 1] == nil #Logic to catch the error of comparing a nil value.
                #require 'pry'; binding.pry
                break
            elsif (number_check[index_loc + 1] - number_check[index_loc]) != 1 && letter_check[index_loc] == letter_check[index_loc + 1] #(number_check[0+1..1+1 (index_loc never == 2 due to the above logice breakinbg the loop beforehand.)] == 1 - number_check[index_loc == 0..2] == 0) == 2 - 1 == 1 Which means this won't run.
                #require 'pry'; binding.pry
                return false #Moving forwards, though, to index_loc == 1, we will arive here. (number_check[2]) - (number_check[1]) == (4) - (2) == 2 WHICH DOESN'T EQUAL 1, BUT WE HAVE && (letter_check[1] == letter_check[1 + 1]) == (A == A) IT PASSES RETURNING FALSE
            elsif (number_check[index_loc + 1] - number_check[index_loc]) != 1 && letter_check[index_loc + 1].ord - letter_check[index_loc].ord != 1
                #require 'pry'; binding.pry
                return false
            elsif (letter_check[index_loc + 1].ord - letter_check[index_loc].ord) != 1 && (number_check[index_loc + 1] - number_check[index_loc]) != 1
                #require 'pry'; binding.pry
                return false
            elsif (letter_check[index_loc+ 1].ord - letter_check[index_loc].ord) == 1 && (number_check[index_loc + 1] - number_check[index_loc]) == 1
                return false
            end
        end

        return true
    end

    def place(ship, cells)
        if valid_placement?(ship, cells)
            ship.length.times do |i|
                if valid_coordinate?(cells[i])
                    # require 'pry'; binding.pry
                    cells_hash[cells[i]].place_ship(ship)
                end
            end
        end
    end
end