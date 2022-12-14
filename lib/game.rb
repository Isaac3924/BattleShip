require './lib/ship'
require './lib/cell'
require './lib/board'

class Game
    attr_reader :player_board,
                :computer_board,
                :computer_cruiser,
                :computer_sub,
                :player_cruiser,
                :player_sub
                
    def initialize
        @player_board = {}
        @computer_board = {}
        @computer_cruiser = Ship.new('Cruiser', 3)
        @computer_sub = Ship.new('Submarine', 2)
        @player_cruiser = Ship.new('Cruiser', 3)
        @player_sub = Ship.new('Submarine', 2)
    end
    
    def main_menu_message
        puts "
        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
        @@@@@@@@@@@@@@@@@@@@@@@@@@@.@@@@@@@@@@@@@ .@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
        @@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@ (@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
        @@@@@@@@@@@@@@@@@@@@@@@@@@, %&@@@@@@@@(&.  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
        @@@@@@@@@@@@@@@@@@@@@@@@%   .@@@@%@@ @.@    .#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
        @@@@@@@@@@@@@@@@@@@@@@,@      @                    @@@@@@@@@@@@@@@@@@@@@@@@@@
        @@@@@@%@@@@@@@@                                     ,@  #*#   /, /. .       @
        @%                                                                        @@@
        @@                                                                     *@@@@@
        ██████╗░░█████╗░████████╗████████╗██╗░░░░░███████╗░██████╗██╗░░██╗██╗██████╗░
        ██╔══██╗██╔══██╗╚══██╔══╝╚══██╔══╝██║░░░░░██╔════╝██╔════╝██║░░██║██║██╔══██╗
        ██████╦╝███████║░░░██║░░░░░░██║░░░██║░░░░░█████╗░░╚█████╗░███████║██║██████╔╝
        ██╔══██╗██╔══██║░░░██║░░░░░░██║░░░██║░░░░░██╔══╝░░░╚═══██╗██╔══██║██║██╔═══╝░
        ██████╦╝██║░░██║░░░██║░░░░░░██║░░░███████╗███████╗██████╔╝██║░░██║██║██║░░░░░
        ╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░╚══════╝╚══════╝╚═════╝░╚═╝░░╚═╝╚═╝╚═╝░░░░░"
        puts "Enter 'p' to play, or enter 'q' to quit."
        print "> "
    end

    def main_menu
        input = ""
        main_menu_message
        input = gets.chomp.downcase

        until input == "p" || input == "q" do
            puts "That is an invalid input, please try again."
            print ">"
            input = gets.chomp.downcase
        end
        
        if input == "p"
            puts "Setting up..."
            setup
        elsif input == "q"
            puts "Quitting the game, see you later!"
            exit
        end
    end

    def place_cruiser
        puts "Enter the squares for the Cruiser (3 spaces):"
        print "> "
        input1 = gets.chomp.upcase
        print "> "
        input2 = gets.chomp.upcase
        print "> "
        input3 = gets.chomp.upcase
        player_cruiser_coords = [input1, input2, input3]

        until @player_board.valid_placement?(@player_cruiser, player_cruiser_coords) == true
            if @player_board.valid_placement?(@player_cruiser, player_cruiser_coords) != true
                puts "Those are invalid coordinates! Please try again:"
                puts ""
                print "> "
                player_cruiser_coords.clear
                input1 = gets.chomp.upcase
                print "> "
                input2 = gets.chomp.upcase
                print "> "
                input3 = gets.chomp.upcase
                player_cruiser_coords = [input1, input2, input3]
            end
        end
        @player_board.place(@player_cruiser, player_cruiser_coords)

        puts "You have placed your Cruiser at: #{player_cruiser_coords}!"
    end

    def place_sub
        puts "Enter the squares for the Submarine (2 spaces):"

        print "> "
        input4 = gets.chomp.upcase
        print "> "
        input5 = gets.chomp.upcase
        player_sub_coords = [input4, input5]

        until @player_board.valid_placement?(@player_sub, player_sub_coords) == true
            if @player_board.place(@player_sub, player_sub_coords) != true
                puts "Those are invalid coordinates! Please try again:"
                player_sub_coords.clear
                print "> "
                input4 = gets.chomp.upcase
                print "> "
                input5 = gets.chomp.upcase
                player_sub_coords = [input4, input5]
            end
        end
        @player_board.place(@player_sub, player_sub_coords)
        puts "You have placed your Submarine at: #{player_sub_coords}!"
    end

    def setup
        @computer_cruiser = Ship.new('Cruiser', 3)
        @computer_sub = Ship.new('Submarine', 2)
        
        @player_cruiser = Ship.new('Cruiser', 3)
        @player_sub = Ship.new('Submarine', 2)

        @computer_board = Board.new
        @computer_board.cells

        
        @computer_board.place(@computer_cruiser, computer_cruiser_coords)
        @computer_board.place(@computer_sub, computer_sub_coords)

        @player_board = Board.new
        @player_board.cells

        puts "I have laid out my ships on the grid."
        puts "You now need to lay out your 2 ships."
        puts "The Cruiser is 3 units long, and the Submarine is 2 units long."
        puts @player_board.render(true)
        
        place_cruiser

        puts ""
        puts @player_board.render(true)
        
        place_sub

        puts ""
        puts @player_board.render(true)

        turn
    end

    def computer_cruiser_coords
        letter_array = @computer_board.cells_hash.keys
        coord_array = []
        
        until @computer_board.valid_placement?(@computer_sub, coord_array) == true

            first = letter_array.sample
            coord_array << first
            second = letter_array.sample
            coord_array << second
            third = letter_array.sample
            coord_array << third

            if @computer_board.valid_placement?(@computer_cruiser, coord_array) == false
                coord_array.clear
            elsif @computer_board.valid_placement?(@computer_cruiser, coord_array) == true
                return coord_array
            end
        end
    end

    def computer_sub_coords
        letter_array = @computer_board.cells_hash.keys
        coord_array = []
        
        
        until @computer_board.valid_placement?(@computer_sub, coord_array) == true

            first = letter_array.sample
            coord_array << first
            second = letter_array.sample
            coord_array << second

            if @computer_board.valid_placement?(@computer_sub, coord_array) == false
                coord_array.clear
            elsif @computer_board.valid_placement?(@computer_sub, coord_array) == true
                return coord_array
            end
        end
    end

    def turn
        player_check_array = []
        comp_check_array = []
        game_over = false
        
        puts "THE GAME HAS STARTED"
        game_loop(player_check_array, comp_check_array, game_over)
    end

    def check_valid(fire_input, player_check_array)
        until @computer_board.valid_coordinate?(fire_input) 
            if player_check_array.include?(fire_input)
                puts "You've already fired at that location. Please enter a new coordinate:"
                print "> "
                fire_input = gets.chomp.upcase
            else

                puts "That was an invalid input, please enter a new corrdinate:"
                print "> "
                fire_input = gets.chomp.upcase

                while player_check_array.include?(fire_input)
                    puts "You've already fired at that location. Please enter a new coordinate:"
                    print "> "
                    fire_input = gets.chomp.upcase
                end
            end  
        end

        until player_check_array.include?(fire_input) == false
            if @computer_board.valid_coordinate?(fire_input) == false
                puts "That was an invalid input, please enter a new corrdinate:"
                print "> "
                fire_input = gets.chomp.upcase
            else
                puts "You've already fired at that location. Please enter a new coordinate:"
                print "> "
                fire_input = gets.chomp.upcase
                
                while @computer_board.valid_coordinate?(fire_input) == false
                    puts "That was an invalid input, please enter a new corrdinate:"
                    print "> "
                    fire_input = gets.chomp.upcase
                end
            end
        end
        return fire_input
    end

    def comp_check_valid(comp_fire_input, comp_check_array)
        if comp_check_array.include?(comp_fire_input)
            until comp_check_array.include?(comp_fire_input) == false
                return comp_fire_input = @player_board.cells_hash.keys.sample
            end
        else
            return comp_fire_input
        end
    end

    def turn_messages(fire_input, comp_fire_input)
        if @computer_board.cells_hash[fire_input].render == "M"
            puts "Your shot on #{fire_input} was a miss!"
        elsif @computer_board.cells_hash[fire_input].render == "H"
            puts "Your shot on #{fire_input} was a hit!"
        elsif @computer_board.cells_hash[fire_input].render == "X"
            puts "Your shot on #{fire_input} sunk my ship!"
        end

        if @player_board.cells_hash[comp_fire_input].render == "M"
            puts "My shot on #{comp_fire_input} was a miss!"
        elsif @player_board.cells_hash[comp_fire_input].render == "H"
            puts "My shot on #{comp_fire_input} was a hit!"
        elsif @player_board.cells_hash[comp_fire_input].render == "X"
            puts "My shot on #{comp_fire_input} sunk your ship! MUHAHA!"
        end
    end

    def game_loop(player_check_array, comp_check_array, game_over)
        until game_over == true
            puts ""
            puts "=============COMPUTER BOARD============="
            puts @computer_board.render(false)
            puts "==============PLAYER BOARD=============="
            puts @player_board.render(true)
            puts ""
            puts "Choose a coordinate to fire at:"
            print "> "
            fire_input = gets.chomp.upcase
            
            fire_input = check_valid(fire_input, player_check_array)

            player_check_array << fire_input

            @computer_board.cells_hash[fire_input].fire_upon
            
            comp_fire_input = @player_board.cells_hash.keys.sample
            
            comp_fire_input = comp_check_valid(comp_fire_input, comp_check_array)

            comp_check_array << comp_fire_input

            @player_board.cells_hash[comp_fire_input].fire_upon

            turn_messages(fire_input, comp_fire_input)

            if @player_cruiser.sunk? && @player_sub.sunk?
                game_over = true
                puts "Looks like I won! Better luck next time!"
                main_menu
            elsif @computer_cruiser.sunk? && @computer_sub.sunk?
                game_over = true
                puts "You won! Wait... You won? How is that possible? Play me again if you dare!"
                main_menu
            end
        end
    end
end
