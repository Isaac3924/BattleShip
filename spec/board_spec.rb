require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
    it "#exists" do
        board = Board.new
        board.cells

        expect(board).to be_an_instance_of(Board)
        expect(board.cells_hash).to be_a Hash
        expect(board.cells_hash["A1"]).to be_a Cell
    end

    it "is a valid coordinate" do
        board = Board.new
        board.cells

        expect(board.valid_coordinate?("A1")).to eq(true)
        expect(board.valid_coordinate?("D4")).to eq(true)
        expect(board.valid_coordinate?("A5")).to eq(false)
        expect(board.valid_coordinate?("E1")).to eq(false)
        expect(board.valid_coordinate?("A22")).to eq(false)
    end

    it "is a valid coordinate" do
        board = Board.new
        board.cells

        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)

        # expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
        # expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
        expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq(false)
        expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq(true)
        # expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
        # expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
    end

end