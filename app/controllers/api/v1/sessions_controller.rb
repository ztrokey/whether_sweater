class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: UsersSerializer.new(user), status: 200
    else
      render json: {
        error: 'unable to login with provided credentials', status: 403
      }, status: 403
    end
  end
end
