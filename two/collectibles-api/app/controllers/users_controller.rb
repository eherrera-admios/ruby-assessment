class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
    user = User.create!(name: user_params['name'], username: user_params['username'], password: user_params['password'])
    auth_token = AuthenticateUser.new(user.username, user.password).call
    response = {message: Message.account_created, auth_token: auth_token}
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(
      :name,
      :username,
      :password,
      :password_confirmation
    )
  end
end
