class MapQuestService
  def self.get_coordinates(location)
    response = conn.get('/geocoding/v1/address') do |req|
      req.params['location'] = location
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com', params: { key: ENV['MAPQUEST_KEY'] })
  end
end
