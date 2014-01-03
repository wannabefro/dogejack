class Api::SessionsController < Devise::SessionsController
  respond_to :json
  def create
    user = User.find_for_database_authentication(login: params[:username])

    if user && user.valid_password?(params[:password])
      sign_in user
      @user = user
      render json: { :access_token => user.authentication_token, :token_type => "bearer", user: @user }
    else
      render json: {
        errors: {
          username: "invalid username or password"
        }
      }, status: :unprocessable_entity
    end
  end
end
