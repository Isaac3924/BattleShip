require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
    it "#exists" do
        board = Board.new

        expect(board).to be_an_instance_of(Board)
        expect(board.cells).to be_a Hash
        expect(board.cells["A1"]).to be_a Cell
    end
end