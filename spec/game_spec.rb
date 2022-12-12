require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do
    it "#exists" do
        game = Game.new

        expect(game).to be_an_instance_of(Game)
    end

    it "#has a main menu" do
        game = Game.new

        game.main_menu
    end

    it "has a board for both computer and player" do
        game = Game.new
        game.setup
   
        expect(game.computer_board).to be_an_instance_of(Board)
        expect(game.player_board).to be_an_instance_of(Board)
        expect(game.computer_board.cells_hash["B4"]).to be_an_instance_of(Cell)
        expect(game.player_board.cells_hash["B4"]).to be_an_instance_of(Cell) 
    end

    it "is a valid placement for computer's cruiser" do
        game = Game.new
        game.setup

        expect(game.computer_board.valid_placement?(game.computer_cruiser, game.computer_cruiser_coords)).to eq true
    end

    it "is a valid placement for computer's submarine" do
        game = Game.new
        game.setup

        expect(game.computer_board.valid_placement?(game.computer_sub, game.computer_sub_coords)).to eq true
    end
end
