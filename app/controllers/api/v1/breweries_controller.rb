class Api::V1::BreweriesController < ApplicationController
  def index
    location = params[:location]
    quantity = params[:quantity]

    brewery = BreweryFacade.get_breweries(location, quantity)
    render json: BrewerySerializer.new(brewery)
  end
end
