class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    authenticate_user = AuthenticateUser.new(auth_params[:username], auth_params[:password])
    auth_token = authenticate_user.call
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:username, :password)
  end
end
