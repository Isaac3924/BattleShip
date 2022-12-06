require 'rspec'
require './lib/ship'

RSpec.describe Ship do
    it '1. exists' do
        cruiser = Ship.new

        expect(cruiser).to be_an_instance_of(Ship)
    end
end