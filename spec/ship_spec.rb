require 'rspec'
require './lib/ship'
require './lib/cell'

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

    it '3. is sunk?' do
        cruiser = Ship.new('cruiser', 3)

        expect(cruiser).to be_an_instance_of(Ship)
        expect(cruiser.sunk?).to eq(false)
    end

    it '4. takes a hit' do
        cruiser = Ship.new('cruiser', 3)

        expect(cruiser).to be_an_instance_of(Ship)
        cruiser.hit
        expect(cruiser.health).to eq(2)
    end

    it '5. is sunk after health is zero' do
        cruiser = Ship.new('cruiser', 3)

        expect(cruiser).to be_an_instance_of(Ship)
        cruiser.hit
        cruiser.hit
        cruiser.hit
        expect(cruiser.health).to eq(0)
        expect(cruiser.sunk?).to eq(true)
    end
end