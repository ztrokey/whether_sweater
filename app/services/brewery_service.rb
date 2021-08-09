class BreweryService
  def self.find_breweries(coordinates, quantity)
    response = conn.get('/breweries') do |req|
      req.params['by_dist'] = "#{coordinates[:lat]}, #{coordinates[:lng]}"
      req.params['per_page'] = quantity
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.openbrewerydb.org')
  end
end
