require 'rails_helper'

RSpec.describe 'get background by location' do
  describe 'happy path' do
    it 'creates a user in the db' do
      post '/api/v1/users'

      expect(response).to be_successful
    end
  end
end
# user:
# email
# password_digest
# api_key