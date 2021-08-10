class RoadTripFacade
  def self.get_details(origin, destination)
    coordinates = CoordinatesFacade.coordinates(destination)
    weather_data = WeatherService.get_weather_data(coordinates)
    travel_data = MapQuestService.get_travel_details(origin, destination)
    RoadTrip.new(travel_data, weather_data, origin, destination)
  end
end
