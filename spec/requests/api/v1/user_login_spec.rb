require 'rails_helper'

RSpec.describe 'user login' do
  describe 'happy path' do
    it 'logs in a user with correct information' do
      User.create!(
        email: 'goodemail@ex.com',
        password: 'goodpassword',
        password_confirmation: 'goodpassword'
      )

      login_data = {
        email: 'goodemail@ex.com',
        password: 'goodpassword'
      }
      post '/api/v1/sessions', params: login_data

      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response_data).to be_a(Hash)
      expect(response_data).to have_key(:data)
      expect(response_data[:data]).to be_a(Hash)
      expect(response_data[:data]).to have_key(:id)
      expect(response_data[:data][:id]).to be_a(String)
      expect(response_data[:data]).to have_key(:type)
      expect(response_data[:data][:type]).to eq('users')
      expect(response_data[:data]).to have_key(:attributes)
      expect(response_data[:data][:attributes]).to be_a(Hash)
      expect(response_data[:data][:attributes]).to have_key(:email)
      expect(response_data[:data][:attributes][:email]).to be_a(String)
      expect(response_data[:data][:attributes]).to have_key(:api_key)
      expect(response_data[:data][:attributes][:api_key]).to be_a(String)
      expect(response_data[:data][:attributes]).to_not have_key(:password)
      expect(response_data[:data][:attributes]).to_not have_key(:password_confirmation)
      expect(response_data[:data][:attributes]).to_not have_key(:password_digest)
    end
  end
  describe 'sad path' do
    it 'returns and error if the credentials are incorrect' do
      User.create!(
        email: 'goodemail@ex.com',
        password: 'goodpassword',
        password_confirmation: 'goodpassword'
      )

      login_data = {
        email: 'goodemail@ex.com',
        password: 'BADpassword'
      }
      post '/api/v1/sessions', params: login_data

      expect(response).to_not be_successful
      expect(response.status).to eq(403)

      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response_data).to be_a(Hash)
      expect(response_data).to have_key(:error)
      expect(response_data[:error]).to be_a(String)
      expect(response_data[:error]).to eq('unable to login with provided credentials')
      expect(response_data).to have_key(:status)
      expect(response_data[:status]).to be_a(Integer)
      expect(response_data[:status]).to eq(403)
    end
  end
end
