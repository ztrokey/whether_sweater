class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    user[:email] = user[:email].downcase
    if user.save
      render json: UsersSerializer.new(user), status: 201
    else
      render json: user.errors, status: 422
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
