class Background
  attr_reader :id,
              :image,
              :credit

  def initialize(data, location)
    @id = nil
    @image = image_info(data, location)
    @credit = credit_info(data)
  end

  def image_info(data, location)
    {
      location: location,
      image_url: data[:results].first[:urls][:raw]
    }
  end

  def credit_info(data)
    {
      source: 'https://unsplash.com/',
      author: data[:results].first[:user][:name],
      author_portfolio: data[:results].first[:user][:links][:html]
    }
  end
end
