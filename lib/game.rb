require './lib/ship'
require './lib/cell'
require './lib/board'

class Game
    attr_reader :player_board,
                :computer_board,
                :computer_cruiser
    def initialize
        @player_board = {}
        @computer_board = {}
        @computer_cruiser = Ship.new('Cruiser', 3)

    end
    
    def main_menu
        input = ""
        puts "Welcome to BattleShip!"
        puts "Enter 'p' to play, or enter 'q' to quit."
        input = gets.chomp.downcase

        if input == "p" 
            puts "Setting up..."
            setup
        elsif input == "q"
            puts "quitting the game, see you later!"
            exit
        else
            puts "That is an invalid input, please try again."
        end
    end

    def setup
        @computer_board = Board.new
        @computer_board.cells

        
        @computer_board.place(@computer_cruiser, computer_cruiser_coords)

        @player_board = Board.new
        @player_board.cells

    end

    def computer_cruiser_coords
        letter_array = @computer_board.cells_hash.keys
        coord_array = []
        
        
        until @computer_board.valid_placement?(@computer_cruiser, coord_array) == true

            first = letter_array.sample
            coord_array << first
            second = letter_array.sample
            coord_array << second
            third = letter_array.sample
            coord_array << third

            if @computer_board.valid_placement?(@computer_cruiser, coord_array) == false
            #    require 'pry'; binding.pry
                coord_array.clear
            elsif @computer_board.valid_placement?(@computer_cruiser, coord_array) == true
                # require 'pry'; binding.pry
                return coord_array
            end
        end
    end
end