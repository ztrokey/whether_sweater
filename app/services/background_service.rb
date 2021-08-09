class BackgroundService
  def self.get_background(location)
    response = conn.get('search/photos') do |req|
      req.params['query'] = location
      req.params['per_page'] = 1
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.unsplash.com', params: { client_id: ENV['UNSPLASH_ACCESS_KEY'] })
  end
end
