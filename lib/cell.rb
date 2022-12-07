require './lib/ship' 

class Cell
    attr_reader :coordinate, #coordinate value as a string
                :ship        #ship value as an instance of Ship class

    def initialize(coordinate) #initializes with string of coordinate
        @coordinate = coordinate
        fire = false
    end

    def empty? #if the ship value still isn't assigned, this will be true, meaning no ship at that coordinate
        if ship != nil
            return false
        else
            return true
        end
    end

    def place_ship(ship) #will assign the given argument (meant to be an instance of Ship class) to the ship value
        @ship = ship
    end

    def fired_upon? #Checks if the space was fired_upon via the fire variable named in initialize and the fire_upon method being used.
        if @fire == true
            return true
        else
            return false
        end
    end

    def fire_upon #switches the fire variable to true. if empty? is false, then decreases ship.health by 1
        @fire = true
        #if empty? == false
        #    ship.health -= 1
        #end
    end

    def render
        if fired_upon? == false
            return "."
        elsif fired_upon? == true && empty? == true
            return "M"
        elsif fired_upon? == true && empty? == false
            return "H"
        elsif fired_upon? == true && empty? == false
            4
        else
            5
        end
    end
end
