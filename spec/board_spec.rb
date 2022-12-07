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

        ship = Ship.new("Cruiser", 3)

        board.valid_placement?(ship, ["D42", "B1", "C3"])

        # expect(board.valid_coordinate?("A1")).to eq(true)
        # expect(board.valid_coordinate?("D4")).to eq(true)
        # expect(board.valid_coordinate?("A5")).to eq(false)
        # expect(board.valid_coordinate?("E1")).to eq(false)
        # expect(board.valid_coordinate?("A22")).to eq(false)
    end

end