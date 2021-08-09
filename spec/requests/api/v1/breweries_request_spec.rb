require 'rails_helper'

RSpec.describe 'get breweries by location' do
  describe 'happy path' do
    it 'returns the brewery data', :vcr do
      location = 'denver,co'
      quantity = 5
      get "/api/v1/breweries?location=#{location}&quantity=#{quantity}"

      expect(response).to be_successful

      breweries = JSON.parse(response.body, symbolize_names: true)

      expect(breweries).to have_key(:data)
      expect(breweries[:data]).to be_a(Hash)
      expect(breweries[:data]).to have_key(:id)
      expect(breweries[:data][:id]).to eq(nil)
      expect(breweries[:data]).to have_key(:type)
      expect(breweries[:data][:type]).to be_a(String)
      expect(breweries[:data]).to have_key(:attributes)
      expect(breweries[:data][:attributes]).to have_key(:destination)
      expect(breweries[:data][:attributes][:destination]).to be_a(String)
      expect(breweries[:data][:attributes]).to have_key(:forecast)
      expect(breweries[:data][:attributes][:forecast]).to have_key(:summary)
      expect(breweries[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(breweries[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(breweries[:data][:attributes][:forecast][:temperature]).to be_a(Float)
      expect(breweries[:data][:attributes]).to have_key(:breweries)
      expect(breweries[:data][:attributes][:breweries]).to be_an(Array)
      expect(breweries[:data][:attributes][:breweries].count).to eq(quantity)
      expect(breweries[:data][:attributes][:breweries].first).to be_an(Hash)
      expect(breweries[:data][:attributes][:breweries].first).to have_key(:id)
      expect(breweries[:data][:attributes][:breweries].first[:id]).to be_a(Integer)
      expect(breweries[:data][:attributes][:breweries].first).to have_key(:name)
      expect(breweries[:data][:attributes][:breweries].first[:name]).to be_a(String)
      expect(breweries[:data][:attributes][:breweries].first).to have_key(:brewery_type)
      expect(breweries[:data][:attributes][:breweries].first[:brewery_type]).to be_a(String)
    end
  end
  describe 'sad path' do
    it 'returns an error if info is missing', :vcr do
      location = ' '
      quantity = 5
      get "/api/v1/breweries?location=#{location}&quantity=#{quantity}"
      expect(response).to be_successful

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error).to have_key(:error)
      expect(error[:error]).to be_a(String)
      expect(error).to have_key(:status)
      expect(error[:status]).to be_a(Integer)
    end
  end
end
