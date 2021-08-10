class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(travel_data, weather_data, origin, destination)
    @id = nil
    @start_city = origin
    @end_city = destination
    @travel_time = calculate_travel_time(travel_data)
    @weather_at_eta = weather_at_arrival(travel_data, weather_data)
  end

  def calculate_travel_time(travel_data)
    @travel_time = travel_data[:route][:formattedTime] || 'impossible'
  end

  def weather_at_arrival(travel_data, weather_data)
    if @travel_time == 'impossible'
      {
        temperature: '',
        conditions: ''
      }
    else
      hours = (travel_data[:route][:time].to_f / 3600.0).round
      {
        temperature: weather_data[:hourly][hours][:temp],
        conditions: weather_data[:hourly][hours][:weather].first[:description]
      }
    end
  end
end
