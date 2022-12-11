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

    end
end
