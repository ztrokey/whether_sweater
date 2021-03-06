require 'rails_helper'

RSpec.describe 'get background by location' do
  describe 'happy path' do
    it 'returns background image data', :vcr do
      get '/api/v1/backgrounds?location=denver,co'

      expect(response).to be_successful

      background = JSON.parse(response.body, symbolize_names: true)

      expect(background).to be_a(Hash)
      expect(background).to have_key(:data)
      expect(background[:data]).to be_a(Hash)
      expect(background[:data]).to have_key(:id)
      expect(background[:data][:id]).to eq(nil)
      expect(background[:data]).to have_key(:type)
      expect(background[:data][:type]).to eq('image')
      expect(background[:data]).to have_key(:attributes)
      expect(background[:data][:attributes]).to be_a(Hash)
      expect(background[:data][:attributes]).to have_key(:image)
      expect(background[:data][:attributes][:image]).to be_a(Hash)
      expect(background[:data][:attributes][:image]).to have_key(:location)
      expect(background[:data][:attributes][:image][:location]).to be_a(String)
      expect(background[:data][:attributes][:image]).to have_key(:image_url)
      expect(background[:data][:attributes][:image][:image_url]).to be_a(String)
      expect(background[:data][:attributes]).to have_key(:credit)
      expect(background[:data][:attributes][:credit]).to be_a(Hash)
      expect(background[:data][:attributes][:credit]).to have_key(:source)
      expect(background[:data][:attributes][:credit][:source]).to be_a(String)
      expect(background[:data][:attributes][:credit]).to have_key(:author)
      expect(background[:data][:attributes][:credit][:author]).to be_a(String)
      expect(background[:data][:attributes][:credit]).to have_key(:author_portfolio)
      expect(background[:data][:attributes][:credit][:author_portfolio]).to be_a(String)
    end
  end
  describe 'sad path' do
    it 'requires location to be filled in' do
      get '/api/v1/backgrounds?location='

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
