require './lib/ship'
require './lib/cell'
require './lib/board'

class Game
    attr_reader :player_board,
                :computer_board
    def initialize
        @player_board = {}
        @computer_board = {}

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
end