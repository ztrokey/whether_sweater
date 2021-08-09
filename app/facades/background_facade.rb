class BackgroundFacade
  def self.search_for_background(location)
    data = BackgroundService.get_background(location)
    Background.new(data, location)
  end
end
