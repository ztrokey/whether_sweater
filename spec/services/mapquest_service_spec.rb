require 'rails_helper'

RSpec.describe MapQuestService do
  describe 'get_coordinates' do
    it 'can get the coordinates of a city and state', :vcr do
      location = 'denver,co'

      response = MapQuestService.get_coordinates(location)

      expect(response).to be_a(Hash)
      expect(response).to have_key(:results)
      expect(response[:results]).to be_an(Array)
      expect(response[:results].first).to be_a(Hash)
      expect(response[:results].first).to have_key(:locations)
      expect(response[:results].first[:locations]).to be_an(Array)
      expect(response[:results].first[:locations].first).to be_a(Hash)
      expect(response[:results].first[:locations].first).to have_key(:latLng)
      expect(response[:results].first[:locations].first[:latLng]).to be_a(Hash)
      expect(response[:results].first[:locations].first[:latLng]).to have_key(:lat)
      expect(response[:results].first[:locations].first[:latLng]).to have_key(:lng)
    end
  end
end
