class Api::V1::ForecastController < ApplicationController
  def index
    location = params[:location]

    if params[:location].blank?
      render json: {
        error: 'location cannot be blank',
        status: 406
      }, status: 406
    else
      forecast = ForecastFacade.get_forecast(location)
      render json: ForecastSerializer.new(forecast)
    end
  end
end
