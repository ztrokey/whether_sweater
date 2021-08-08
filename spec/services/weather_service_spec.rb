require 'rails_helper'

RSpec.describe WeatherService do
  describe 'get_weather_data' do
    it 'can get weather data by coordinates', :vcr do
      coordinates = { lat: 39.738453, lng: -104.984853 }

      response = WeatherService.get_weather_data(coordinates)

      expect(response).to be_a(Hash)
      expect(response).to_not have_key(:minutely)
      # current
      expect(response).to have_key(:current)
      expect(response[:current]).to be_a(Hash)
      expect(response[:current]).to have_key(:dt)
      expect(response[:current]).to have_key(:sunrise)
      expect(response[:current]).to have_key(:sunset)
      expect(response[:current]).to have_key(:temp)
      expect(response[:current]).to have_key(:feels_like)
      expect(response[:current]).to have_key(:pressure)
      expect(response[:current]).to have_key(:humidity)
      expect(response[:current]).to have_key(:dew_point)
      expect(response[:current]).to have_key(:uvi)
      expect(response[:current]).to have_key(:clouds)
      expect(response[:current]).to have_key(:visibility)
      expect(response[:current]).to have_key(:wind_speed)
      expect(response[:current]).to have_key(:wind_deg)
      expect(response[:current]).to have_key(:wind_gust)
      expect(response[:current]).to have_key(:weather)
      # hourly
      expect(response).to have_key(:hourly)
      expect(response[:hourly]).to be_an(Array)
      expect(response[:hourly].count).to eq(48)
      expect(response[:hourly].first).to be_a(Hash)
      expect(response[:hourly].first).to have_key(:dt)
      expect(response[:hourly].first).to have_key(:temp)
      expect(response[:hourly].first).to have_key(:feels_like)
      expect(response[:hourly].first).to have_key(:pressure)
      expect(response[:hourly].first).to have_key(:humidity)
      expect(response[:hourly].first).to have_key(:dew_point)
      expect(response[:hourly].first).to have_key(:uvi)
      expect(response[:hourly].first).to have_key(:clouds)
      expect(response[:hourly].first).to have_key(:visibility)
      expect(response[:hourly].first).to have_key(:wind_speed)
      expect(response[:hourly].first).to have_key(:wind_deg)
      expect(response[:hourly].first).to have_key(:wind_gust)
      expect(response[:hourly].first).to have_key(:weather)
      expect(response[:hourly].first).to have_key(:pop)
      # daily
      expect(response).to have_key(:daily)
      expect(response[:daily]).to be_a(Array)
      expect(response[:daily].count).to eq(8)
      expect(response[:daily].first).to be_a(Hash)
      expect(response[:daily].first).to have_key(:dt)
      expect(response[:daily].first).to have_key(:sunrise)
      expect(response[:daily].first).to have_key(:sunset)
      expect(response[:daily].first).to have_key(:moonrise)
      expect(response[:daily].first).to have_key(:moonset)
      expect(response[:daily].first).to have_key(:moon_phase)
      expect(response[:daily].first).to have_key(:temp)
      expect(response[:daily].first).to have_key(:feels_like)
      expect(response[:daily].first).to have_key(:pressure)
      expect(response[:daily].first).to have_key(:humidity)
      expect(response[:daily].first).to have_key(:dew_point)
      expect(response[:daily].first).to have_key(:uvi)
      expect(response[:daily].first).to have_key(:clouds)
      expect(response[:daily].first).to have_key(:wind_speed)
      expect(response[:daily].first).to have_key(:wind_deg)
      expect(response[:daily].first).to have_key(:wind_gust)
      expect(response[:daily].first).to have_key(:pop)
    end
  end
end
