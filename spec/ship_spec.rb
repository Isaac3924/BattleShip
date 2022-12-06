require 'rspec'
require './lib/ship'

RSpec.describe Ship do
    it '1. exists' do
        cruiser = Ship.new('cruiser', 3)

        expect(cruiser).to be_an_instance_of(Ship)
    end

    it '2. has attributes' do
        cruiser = Ship.new('cruiser', 3)

        expect(cruiser.name).to eq('cruiser')
        expect(cruiser.length).to eq (3)
        expect(cruiser.health).to eq (3)
    end
end