require './lib/ship' 

class Cell
    attr_reader :coordinate, #coordinate value as a string
                :ship        #ship value as an instance of Ship class

    def initialize(coordinate) #initializes with string of coordinate
        @coordinate = coordinate
        @ship = nil
        @fire = false
    end

    def empty? #if the ship value still isn't assigned, this will be true, meaning no ship at that coordinate
        if ship.instance_of? Ship
            return false
        else
            return true
        end
    end

    def place_ship(ship) #will assign the given argument (meant to be an instance of Ship class) to the ship value
        #require 'pry'; binding.pry
        @ship = ship
    end

    def fired_upon? #Checks if the space was fired_upon via the fire variable named in initialize and the fire_upon method being used.
        if @fire == true
            return true
        else
            #require 'pry'; binding.pry
            return false
        end
    end

    def fire_upon #switches the fire variable to true. if empty? is false, then decreases ship.health by 1
        @fire = true
        if empty? == false
            ship.hit
        end
    end

    def render #sets up cell image for board depending on whether the cell was fired at, has a ship, and whether that ship has sunk.
        if fired_upon? == false
            return "."
        elsif fired_upon? == true && empty? == true
            return "M"
        elsif fired_upon? == true && empty? == false && ship.sunk? == false
            return "H"
        elsif fired_upon? == true && empty? == false && ship.sunk? == true
            return "X"
        else
            return "?"
        end
    end
end
