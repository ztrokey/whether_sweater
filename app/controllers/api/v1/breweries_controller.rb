class Api::V1::BreweriesController < ApplicationController
  def index
    location = params[:location]
    quantity = params[:quantity]

    if params[:location].blank?
      render json: {
        error: 'location cannot be blank',
        status: 406
      }
    else
      brewery = BreweryFacade.get_breweries(location, quantity)
      render json: BrewerySerializer.new(brewery)
    end

    # brewery = BreweryFacade.get_breweries(location, quantity)
    # render json: BrewerySerializer.new(brewery)
  end
end
