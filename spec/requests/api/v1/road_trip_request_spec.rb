require 'rails_helper'

RSpec.describe 'road trip' do
  describe 'happy path' do
    it 'provides data for a road trip', :vcr do
      user = User.create!(
        email: 'goodemail@ex.com',
        password: 'goodpassword',
        password_confirmation: 'goodpassword'
      )
      search_body = {
        origin: 'denver,co',
        destination: 'fort collins,co',
        api_key: user.api_key.to_s
      }
      post '/api/v1/road_trip', params: search_body

      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response_data).to be_a(Hash)
      expect(response_data).to have_key(:data)
      expect(response_data[:data]).to have_key(:id)
      expect(response_data[:data][:id]).to eq(nil)
      expect(response_data[:data]).to have_key(:type)
      expect(response_data[:data][:type]).to eq('roadtrip')
      expect(response_data[:data]).to have_key(:attributes)
      expect(response_data[:data][:attributes]).to be_a(Hash)
      expect(response_data[:data][:attributes]).to have_key(:start_city)
      expect(response_data[:data][:attributes][:start_city]).to be_a(String)
      expect(response_data[:data][:attributes]).to have_key(:end_city)
      expect(response_data[:data][:attributes][:end_city]).to be_a(String)
      expect(response_data[:data][:attributes]).to have_key(:travel_time)
      expect(response_data[:data][:attributes][:travel_time]).to be_a(String)
      expect(response_data[:data][:attributes]).to have_key(:weather_at_eta)
      expect(response_data[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(response_data[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(response_data[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(response_data[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
      expect(response_data[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end
  end
  describe 'sad path' do
    it 'returns an error if api key is invalid', :vcr do
      user = User.create!(
        email: 'goodemail@ex.com',
        password: 'goodpassword',
        password_confirmation: 'goodpassword'
      )
      search_body = {
        origin: 'denver,co',
        destination: 'fort collins,co',
        api_key: 'madeUpKey'
      }
      post '/api/v1/road_trip', params: search_body

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response_data).to be_a(Hash)
      expect(response_data).to have_key(:error)
      expect(response_data[:error]).to be_a(String)
      expect(response_data).to have_key(:status)
      expect(response_data[:status]).to be_a(Integer)
    end
    it 'knows what is impossible', :vcr do
      user = User.create!(
        email: 'goodemail@ex.com',
        password: 'goodpassword',
        password_confirmation: 'goodpassword'
      )
      search_body = {
        origin: 'denver,co',
        destination: 'london,uk',
        api_key: user.api_key.to_s
      }
      post '/api/v1/road_trip', params: search_body

      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response_data).to be_a(Hash)
      expect(response_data).to have_key(:data)
      expect(response_data[:data]).to have_key(:id)
      expect(response_data[:data][:id]).to eq(nil)
      expect(response_data[:data]).to have_key(:type)
      expect(response_data[:data][:type]).to eq('roadtrip')
      expect(response_data[:data]).to have_key(:attributes)
      expect(response_data[:data][:attributes]).to be_a(Hash)
      expect(response_data[:data][:attributes]).to have_key(:start_city)
      expect(response_data[:data][:attributes][:start_city]).to be_a(String)
      expect(response_data[:data][:attributes]).to have_key(:end_city)
      expect(response_data[:data][:attributes][:end_city]).to be_a(String)
      expect(response_data[:data][:attributes]).to have_key(:travel_time)
      expect(response_data[:data][:attributes][:travel_time]).to be_a(String)
      expect(response_data[:data][:attributes][:travel_time]).to eq('impossible')
      expect(response_data[:data][:attributes]).to have_key(:weather_at_eta)
      expect(response_data[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(response_data[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(response_data[:data][:attributes][:weather_at_eta][:temperature].blank?).to eq(true)
      expect(response_data[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
      expect(response_data[:data][:attributes][:weather_at_eta][:conditions].blank?).to eq(true)
    end
    it 'requires origin' do
      user = User.create!(
        email: 'goodemail@ex.com',
        password: 'goodpassword',
        password_confirmation: 'goodpassword'
      )
      search_body = {
        origin: '',
        destination: 'dallas,tx',
        api_key: user.api_key.to_s
      }
      post '/api/v1/road_trip', params: search_body

      expect(response).to_not be_successful
      expect(response.status).to eq(406)

      error_message = JSON.parse(response.body, symbolize_names: true)

      expect(error_message).to be_a(Hash)
      expect(error_message).to have_key(:error)
      expect(error_message[:error]).to be_a(String)
      expect(error_message[:error]).to eq('locations cannot be blank')
      expect(error_message).to have_key(:status)
      expect(error_message[:status]).to be_a(Integer)
      expect(error_message[:status]).to eq(406)
    end
    it 'requires destination' do
      user = User.create!(
        email: 'goodemail@ex.com',
        password: 'goodpassword',
        password_confirmation: 'goodpassword'
      )
      search_body = {
        origin: 'denver,co',
        destination: '',
        api_key: user.api_key.to_s
      }
      post '/api/v1/road_trip', params: search_body

      expect(response).to_not be_successful
      expect(response.status).to eq(406)

      error_message = JSON.parse(response.body, symbolize_names: true)

      expect(error_message).to be_a(Hash)
      expect(error_message).to have_key(:error)
      expect(error_message[:error]).to be_a(String)
      expect(error_message[:error]).to eq('locations cannot be blank')
      expect(error_message).to have_key(:status)
      expect(error_message[:status]).to be_a(Integer)
      expect(error_message[:status]).to eq(406)
    end
  end
end
