class BreweryFacade
  def self.get_breweries(location, quantity)
    coordinates = CoordinatesFacade.coordinates(location)
    weather_data = WeatherService.get_weather_data(coordinates)
    brewery_data = BreweryService.find_breweries(coordinates, quantity)
    Brewery.new(weather_data, brewery_data, location)
  end
end
