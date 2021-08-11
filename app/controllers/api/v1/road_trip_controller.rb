class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user.nil?
      render json: {
        error: 'Unauthorized access', status: 401
      }, status: 401
    elsif params[:origin].blank? || params[:destination].blank?
      render json: {
        error: 'locations cannot be blank',
        status: 406
      }, status: 406
    else
      origin = params[:origin]
      destination = params[:destination]
      road_trip = RoadTripFacade.get_details(origin, destination)
      render json: RoadTripSerializer.new(road_trip)
    end
  end
end
