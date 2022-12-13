require './lib/ship' 

class Cell
    attr_reader :coordinate,
                :ship

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @fire = false
    end

    def empty?
        if ship.instance_of? Ship
            return false
        else
            return true
        end
    end

    def place_ship(ship)
        @ship = ship
    end

    def fired_upon?
        if @fire == true
            return true
        else
            return false
        end
    end

    def fire_upon
        @fire = true
        if empty? == false
            ship.hit
        end
    end

    def render
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
