require 'rails_helper'

RSpec.describe 'get background by location' do
  describe 'happy path' do
    it 'creates a user in the db and sets api key' do
      fe_params = {
        email: 'anitanappe@ex.com',
        password: 'sleepy1',
        password_confirmation: 'sleepy1'
      }
      post '/api/v1/users', params: fe_params

      expect(response).to be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)
      user = User.last

      expect(response_data).to be_a(Hash)
      expect(response_data).to have_key(:data)
      expect(response_data[:data]).to be_a(Hash)
      expect(response_data[:data]).to have_key(:id)
      expect(response_data[:data][:id]).to eq(user.id.to_s)
      expect(response_data[:data]).to have_key(:type)
      expect(response_data[:data][:type]).to eq('users')
      expect(response_data[:data]).to have_key(:attributes)
      expect(response_data[:data][:attributes]).to be_a(Hash)
      expect(response_data[:data][:attributes]).to have_key(:email)
      expect(response_data[:data][:attributes][:email]).to eq(user.email.to_s)
      expect(response_data[:data][:attributes]).to have_key(:api_key)
      expect(response_data[:data][:attributes][:api_key]).to eq(user.api_key.to_s)
      expect(response_data[:data][:attributes]).to_not have_key(:password)
      expect(response_data[:data][:attributes]).to_not have_key(:password_confirmation)
      expect(response_data[:data][:attributes]).to_not have_key(:password_digest)
    end
  end
  describe 'sad path' do
    it 'returns and error if the passwords do not match' do
      fe_params = {
        email: 'chrispbacon@ex.com',
        password: 'goodpassword',
        password_confirmation: 'badpassword'
      }
      post '/api/v1/users', params: fe_params

      expect(response.status).to eq(422)

      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response).to be_a(Hash)
      expect(error_response).to have_key(:password_confirmation)
      expect(error_response[:password_confirmation]).to eq(["doesn't match Password"])
    end
  end
end
