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

      expect(forecast[:data][:attributes]).to_not have_key(:minutely)
    end
  end
  describe 'sad path' do
    it 'requires location to be filled in' do
      get '/api/v1/forecast?location='

      expect(response).to_not be_successful
      expect(response.status).to eq(406)

      error_message = JSON.parse(response.body, symbolize_names: true)

      expect(error_message).to be_a(Hash)
      expect(error_message).to have_key(:error)
      expect(error_message[:error]).to be_a(String)
      expect(error_message[:error]).to eq('location cannot be blank')
      expect(error_message).to have_key(:status)
      expect(error_message[:status]).to be_a(Integer)
      expect(error_message[:status]).to eq(406)
    end
  end
end
