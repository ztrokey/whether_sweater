require 'rails_helper'

RSpec.describe BackgroundService do
  describe 'get_background' do
    it 'can get an image of a city and state', :vcr do
      location = 'denver,co'

      response = BackgroundService.get_background(location)
      expect(response).to be_a(Hash)
      expect(response).to have_key(:total)
      expect(response).to have_key(:total_pages)
      expect(response).to have_key(:results)
      expect(response[:results]).to be_an(Array)
      expect(response[:results].first).to be_a(Hash)
      expect(response[:results].first).to have_key(:urls)
      expect(response[:results].first[:urls]).to be_a(Hash)
      expect(response[:results].first[:urls]).to have_key(:raw)
      expect(response[:results].first[:urls][:raw]).to be_a(String)
      expect(response[:results].first).to have_key(:user)
      expect(response[:results].first[:user]).to be_a(Hash)
      expect(response[:results].first[:user]).to have_key(:name)
      expect(response[:results].first[:user][:name]).to be_a(String)
      expect(response[:results].first[:user]).to have_key(:links)
      expect(response[:results].first[:user][:links]).to be_a(Hash)
      expect(response[:results].first[:user][:links]).to have_key(:html)
      expect(response[:results].first[:user][:links][:html]).to be_a(String)
    end
  end
end
