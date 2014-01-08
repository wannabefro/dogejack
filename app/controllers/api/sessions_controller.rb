class Api::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = User.find_for_database_authentication(login: params[:username])

    if user && user.valid_password?(params[:password])
      sign_in user
      @user = user
      render json: { :access_token => user.authentication_token, :token_type => "bearer", user: [UserSerializer.new(@user)] }
    else
      render json: {
        errors: {
          username: "invalid username or password"
        }
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @user=User.find_by_authentication_token(request.authorization.split(' ')[1])
    if @user.nil?
      logger.info('Token not found.')
      render :status=>404, json: {message: 'Invalid token'}
    else
      @user.reset_authentication_token!
      sign_out @user
      render :status=>200, json: :success
    end
  end
end
