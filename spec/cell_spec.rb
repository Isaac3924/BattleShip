require './lib/cell'
require './lib/ship'
require 'rspec'

RSpec.describe Cell do
    it "exists" do
        cell = Cell.new("B4")
  
        expect(cell).to be_an_instance_of(Cell)
    end
  
    it "has readable attributes" do
        cell = Cell.new("B4")
  
        expect(cell.coordinate).to eq("B4")
        expect(cell.ship).to eq(nil)
    end

    it "can see the cell is empty" do
        cell = Cell.new("B4")
  
        expect(cell.empty?).to eq(true)
    end

    it "can see the cell is empty" do
        cell = Cell.new("B4") 
        cruiser = 1 #Will replace with an instance of Ship later
  
        cell.place_ship(cruiser)

        expect(cell.ship).to eq(1)
        expect(cell.empty?).to eq(false)
    end

    it "knows it has been fired upon" do
        cell = Cell.new("B4") 
        cruiser = 1 #Will replace with an instance of Ship later
  
        cell.place_ship(cruiser)

        expect(cell.fired_upon?).to eq(false)

        cell.fire_upon

        #expect(cell.ship.health).to eq(2)
        expect(cell.fired_upon?).to eq(true)
    end
  end
