require 'rails_helper'

RSpec.describe 'BreweryFacade' do
  it 'finds breweries based off of location' do
    VCR.use_cassette("creates_a_brewery_object") do
      location = 'denver,co'
      quantity = 5

      found_breweries = BreweryFacade.get_breweries(location, quantity)

      expect(found_breweries).to be_a(Brewery)
      expect(found_breweries.breweries.count).to eq(quantity)
      expect(found_breweries.breweries.first).to be_a(Hash)
      expect(found_breweries.breweries.first).to have_key(:id)
      expect(found_breweries.breweries.first[:id]).to be_a(Integer)
      expect(found_breweries.breweries.first).to have_key(:name)
      expect(found_breweries.breweries.first[:name]).to be_a(String)
      expect(found_breweries.breweries.first).to have_key(:brewery_type)
      expect(found_breweries.breweries.first[:brewery_type]).to be_a(String)
      expect(found_breweries.destination).to eq(location)
      expect(found_breweries.id).to eq(nil)
      expect(found_breweries.forecast).to be_a(Hash)
      expect(found_breweries.forecast).to have_key(:summary)
      expect(found_breweries.forecast[:summary]).to be_a(String)
      expect(found_breweries.forecast).to have_key(:temperature)
      expect(found_breweries.forecast[:temperature]).to be_a(Float)
    end
  end
end
