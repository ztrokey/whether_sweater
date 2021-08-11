class Api::V1::BackgroundsController < ApplicationController
  def index
    location = params[:location]
    if params[:location].blank?
      render json: {
        error: 'location cannot be blank',
        status: 406
      }, status: 406
    else
      background_info = BackgroundFacade.search_for_background(location)
      render json: BackgroundSerializer.new(background_info)
    end
  end
end
