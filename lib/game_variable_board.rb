require './lib/ship'
require './lib/cell'
require './lib/board_variable'

class Game_Variable_Board
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
    
    def main_menu
        input = ""
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
        input = gets.chomp.downcase

        if input == "p" 
            setup
        elsif input == "q"
            puts "Quitting the game, see you later!"
            exit
        else
            puts "That is an invalid input, please try again."
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
        width = 0
        height = ""
        @computer_cruiser = Ship.new('Cruiser', 3)
        @computer_sub = Ship.new('Submarine', 2)
        
        @player_cruiser = Ship.new('Cruiser', 3)
        @player_sub = Ship.new('Submarine', 2)

        puts "Please input a number value between 0 and 999 for the width of the board:"
        print "> "
        width = gets.chomp.to_i

        until width > 0 && width <= 999
            puts "That is not a valid number! Please try again:"
            puts ""
            print "> "
            width = gets.chomp.to_i
        end
        puts "Your board is #{width} units wide."

        puts "Please input a max letter between A and Z for the height of the board:"
        print "> "
        height = gets.chomp.upcase

        until height.chars.length == 1
            puts "That is too many letters! Please try again:"
            puts ""
            print "> "
            height = gets.chomp.upcase
        end
        puts "Your board goes down to #{height}"
        puts "Setting up..."

        @computer_board = Variable_Board.new(width, height)
        @computer_board.cells

        
        @computer_board.place(@computer_cruiser, computer_cruiser_coords)
        @computer_board.place(@computer_sub, computer_sub_coords)

        @player_board = Variable_Board.new(width, height)
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
    end

    def game_loop(player_check_array, comp_check_array, game_over)

        comp_choices = @player_board.cells_hash.keys
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
            
            check_valid(fire_input, player_check_array)

            player_check_array << fire_input

            @computer_board.cells_hash[fire_input].fire_upon
            
            #COMPUTER FIRE LOGIC STARTS HERE
            comp_fire_input = ""
            
            require 'pry'; binding.pry
            if comp_check_array != [] && @player_board.cells_hash[comp_check_array.last].render == "H"
                comp_fire_input = comp_choices.sample
                require 'pry'; binding.pry
                @player_board.cells_hash.keys.each do |cell|
                    if cell.chars.length == 2
                        cell_number = cell.chars[1].to_i
                    elsif cell.chars.length == 3
                        cell_number =  "#{cell.chars[1]}#{cell.chars[2]}".to_i
                    elsif cell.chars.length == 4
                        cell_number =  "#{cell.chars[1]}#{cell.chars[2]}#{cell.chars[3]}".to_i
                    end

                    if comp_check_array.last.chars.length == 2
                        comp_number = comp_check_array.last.chars[1].to_i
                    elsif comp_check_array.last.chars.length == 3
                        comp_number =  "#{comp_check_array.last.chars[1]}#{comp_check_array.last.chars[2]}".to_i
                    elsif comp_check_array.last.chars.length == 4
                        comp_number =  "#{comp_check_array.last.chars[1]}#{comp_check_array.last.chars[2]}#{comp_check_array.last.chars[3]}".to_i
                    end

                    if cell.chars[0].ord - comp_check_array.last.chars[0].ord == -1 && cell_number == comp_number && @player_board.cells_hash[cell].render == "."
                        comp_fire_input = cell
                        require 'pry'; binding.pry
                        @player_board.cells_hash[cell].fire_upon
                        comp_choices.delete(cell)
                        break
                    elsif cell.chars[0].ord - comp_check_array.last.chars[0].ord == 1 && cell_number == comp_number && @player_board.cells_hash[cell].render == "."
                        comp_fire_input = cell
                        require 'pry'; binding.pry
                        @player_board.cells_hash[cell].fire_upon
                        comp_choices.delete(cell)
                        break
                    elsif cell.chars[0] == comp_check_array.last.chars[0] && cell_number - comp_number == -1 && @player_board.cells_hash[cell].render == "."
                        comp_fire_input = cell
                        require 'pry'; binding.pry
                        @player_board.cells_hash[cell].fire_upon
                        comp_choices.delete(cell)
                        break
                    elsif cell.chars[0] == comp_check_array.last.chars[0] && cell_number - comp_number == 1 && @player_board.cells_hash[cell].render == "."
                        comp_fire_input = cell
                        require 'pry'; binding.pry
                        @player_board.cells_hash[cell].fire_upon
                        comp_choices.delete(cell)
                        break
                    end
                    
                end
            elsif comp_check_array.include?(comp_fire_input)
                require 'pry'; binding.pry
                until comp_check_array.include?(comp_fire_input) == false
                    require 'pry'; binding.pry
                    comp_fire_input = comp_choices.sample
                    require 'pry'; binding.pry
                end
                @player_board.cells_hash[comp_fire_input].fire_upon
                comp_choices.delete(comp_fire_input)
                require 'pry'; binding.pry
            else 
                comp_fire_input = comp_choices.sample
                @player_board.cells_hash[comp_fire_input].fire_upon
                comp_choices.delete(comp_fire_input)
                require 'pry'; binding.pry
            end
            comp_check_array << comp_fire_input

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
