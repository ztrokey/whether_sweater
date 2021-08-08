class ForecastFacade
  def self.get_forecast(location)
    coordinates = CoordinatesFacade.coordinates(location)
    weather_data = WeatherService.get_weather_data(coordinates)
    Forecast.new(weather_data)
  end
end
