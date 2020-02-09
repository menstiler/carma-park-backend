class AuthController < ApplicationController
  
  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      token = encode_token(user.id)
      user_string = UserSerializer.new(user)
      render json: { user: user_string, token: token }
    else
      render json: {errors: "Something went wrong! Please try again!"}
    end
  end

  def auto_login
    if session_user
      render json: session_user
    else
      render json: {errors: "Please enter a valid user!"}
    end
  end
end
