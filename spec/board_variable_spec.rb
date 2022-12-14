require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board_variable'

RSpec.describe Variable_Board do
    it "#exists" do
        board = Variable_Board.new(5, "E")
        board.cells

        expect(board).to be_an_instance_of(Variable_Board)
        expect(board.cells_hash).to be_a Hash
        expect(board.cells_hash["A1"]).to be_a Cell
    end

    it "is a valid coordinate" do
        board = Variable_Board.new(12, "E")
        board.cells

        expect(board.valid_coordinate?("A1")).to eq(true)
        expect(board.valid_coordinate?("D4")).to eq(true)
        expect(board.valid_coordinate?("A5")).to eq(true)
        expect(board.valid_coordinate?("E1")).to eq(true)
        expect(board.valid_coordinate?("A11")).to eq(true)
        expect(board.valid_coordinate?("F1")).to eq(false)
        expect(board.valid_coordinate?("C27")).to eq(false)
    end

    it "is a valid coordinate position" do
        board = Variable_Board.new(12, "E")
        board.cells

        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)

        expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
        expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
        expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq(false)
        expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq(true)
        expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
        expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
        expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
        expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
        expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq(false)
        expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
        expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)
        expect(board.valid_placement?(cruiser, ["C1", "D1", "E1"])).to eq(true)
        expect(board.valid_placement?(cruiser, ["A3", "A4", "A5"])).to eq(true)
        expect(board.valid_placement?(cruiser, ["B1", "B2", "C1"])).to eq(false)
        expect(board.valid_placement?(cruiser, ["C3", "D1", "C2"])).to eq(false)
        expect(board.valid_placement?(cruiser, ["B3", "C3", "D2"])).to eq(false)
        expect(board.valid_placement?(cruiser, ["C2", "C3", "D3"])).to eq(false)
        expect(board.valid_placement?(cruiser, ["A1", "B1", "A2"])).to eq(false)
        expect(board.valid_placement?(cruiser, ["E1", "E2", "E3"])).to eq(true)
        expect(board.valid_placement?(cruiser, ["C11", "D11", "E11"])).to eq(true)
    end
    
    it "can place ships" do
        board = Variable_Board.new(12, "E")
        board.cells

        cruiser = Ship.new("Cruiser", 3)

        expect(board).to be_an_instance_of(Variable_Board)
        expect(cruiser).to be_an_instance_of(Ship)

        #DON'T WORK Unless you use memorization.
        cell_1 = board.cells["A1"]
        cell_2 = board.cells["A2"]
        cell_3 = board.cells["A3"]

        board.place(cruiser,["A1", "A2", "A3"])

        expect(cell_1).to be_an_instance_of(Cell)
        expect(cell_2).to be_an_instance_of(Cell)
        expect(cell_3).to be_an_instance_of(Cell)
        
        expect(board.cells_hash["A1"].ship).to be_an_instance_of(Ship)
        expect(board.cells_hash["A2"].ship).to be_an_instance_of(Ship)
        expect(cell_3.ship).to be_an_instance_of(Ship)
    end

    it "cannot place ships on overlapping" do
        board = Variable_Board.new(12, "E")
        board.cells

        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)

        expect(board).to be_an_instance_of(Variable_Board)
        expect(cruiser).to be_an_instance_of(Ship)
        expect(submarine).to be_an_instance_of(Ship)

        board.place(cruiser,["A1", "A2", "A3"])
        board.place(submarine,["A1", "B1"])

        expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq(false)
    end

    it "can render the board" do
        board = Variable_Board.new(5, "E")
        board.cells

        cruiser = Ship.new("Cruiser", 3)

        board.place(cruiser,["A1", "A2", "A3"])

        expect(board.render(false)).to eq("  1 2 3 4 5 \nA . . . . . \nB . . . . . \nC . . . . . \nD . . . . . \nE . . . . . \n")
        expect(board.render(true)).to eq("  1 2 3 4 5 \nA S S S . . \nB . . . . . \nC . . . . . \nD . . . . . \nE . . . . . \n")
    end
end