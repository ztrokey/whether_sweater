class WeatherService
  def self.get_weather_data(coordinates)
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['lat'] = coordinates[:lat]
      req.params['lon'] = coordinates[:lng]
      req.params['exclude'] = 'minutely'
      req.params['units'] = 'imperial'
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://api.openweathermap.org', params: { appid: ENV['OPENWEATHER_KEY'] })
  end
end
