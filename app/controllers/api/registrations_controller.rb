class Api::RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)

    if resource.save
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        return render json: {user: resource, access_token: resource.authentication_token, token_type: 'bearer'}
      else
        expire_session_data_after_sign_in!
        return render :json => {:success => true}
      end
    else
      clean_up_passwords resource
      return render :status => 401, :json => {:errors => resource.errors}
    end
  end

  protected

  def sign_up_params
    params.require(:user).permit( :email, :password, :password_confirmation, :username)
  end
end
