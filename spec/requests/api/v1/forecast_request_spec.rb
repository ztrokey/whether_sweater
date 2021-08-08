require 'rails_helper'

RSpec.describe 'get forecast by location' do
  describe 'happy path' do
    it 'returns the weather data', :vcr do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast).to have_key(:data)
      expect(forecast[:data]).to be_a(Hash)
      expect(forecast[:data]).to have_key(:id)
      expect(forecast[:data][:id]).to eq(nil)
      expect(forecast[:data]).to have_key(:type)
      expect(forecast[:data]).to have_key(:attributes)
      expect(forecast[:data][:attributes]).to be_a(Hash)
      expect(forecast[:data][:attributes]).to have_key(:current_weather)
      expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)

      expect(forecast[:data][:attributes]).to have_key(:daily_weather)

      expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
    end
  end
end

# GET /api/v1/forecast?location=denver,co
# Content-Type: application/json
# Accept: application/json