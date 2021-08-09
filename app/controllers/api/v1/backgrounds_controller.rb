class Api::V1::BackgroundsController < ApplicationController
  def index
    location = params[:location]

    background_info = BackgroundFacade.search_for_background(location)
    render json: BackgroundSerializer.new(background_info)
  end
end
