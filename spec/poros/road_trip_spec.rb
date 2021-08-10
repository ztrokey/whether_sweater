require 'rails_helper'

RSpec.describe RoadTrip do
  it 'creates a roadtrip object', :vcr do
    origin = 'denver,co'
    destination = 'fort collins,co'

    road_trip_object = RoadTripFacade.get_details(origin, destination)

    expect(road_trip_object).to be_a(RoadTrip)
    expect(road_trip_object.id).to eq(nil)
    expect(road_trip_object.start_city).to eq(origin)
    expect(road_trip_object.end_city).to eq(destination)
    expect(road_trip_object.travel_time).to be_a(String)
    expect(road_trip_object.weather_at_eta).to be_a(Hash)
    expect(road_trip_object.weather_at_eta).to have_key(:temperature)
    expect(road_trip_object.weather_at_eta[:temperature]).to be_a(Float)
    expect(road_trip_object.weather_at_eta).to have_key(:conditions)
    expect(road_trip_object.weather_at_eta[:conditions]).to be_a(String)
  end
end
