require 'rails_helper'

RSpec.describe BreweryService do
  describe 'find_breweries' do
    it 'finds breweries by location' do
      VCR.use_cassette('returns_the_brewery_data') do
        coordinates = { lat: 39.738453, lng: -104.984853 }
        quantity = 5

        found_breweries = BreweryService.find_breweries(coordinates, quantity)

        expect(found_breweries).to be_an(Array)
        expect(found_breweries.count).to eq(quantity)
        expect(found_breweries.first).to be_a(Hash)
        expect(found_breweries.first).to have_key(:id)
        expect(found_breweries.first[:id]).to be_a(Integer)
        expect(found_breweries.first).to have_key(:name)
        expect(found_breweries.first[:name]).to be_a(String)
        expect(found_breweries.first).to have_key(:brewery_type)
        expect(found_breweries.first[:brewery_type]).to be_a(String)
      end
    end
  end
end
