class Brewery
  attr_reader :id,
              :destination,
              :forecast,
              :breweries

  def initialize(weather_data, brewery_data, location)
    @id = nil
    @destination = location
    @forecast = forecast_info(weather_data)
    @breweries = brewery_info(brewery_data)
  end

  def forecast_info(weather_data)
    {
      summary: weather_data[:current][:weather].first[:description],
      temperature: weather_data[:current][:temp]
    }
  end

  def brewery_info(brewery_data)
    # may need to change to look more like daily and hourly forecast poro?
    brewery_data.map do |brewery|
      {
        id: brewery[:id],
        name: brewery[:name],
        brewery_type: brewery[:brewery_type]
      }
    end
  end
end
