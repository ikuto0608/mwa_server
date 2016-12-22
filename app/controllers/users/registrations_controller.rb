class Users::RegistrationsController < Devise::RegistrationsController
  # POST /resource
  def create
    super do |user|
      render json: payload(user) and return
    end
  end

  private
    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def payload(user)
      return nil unless user and user.id
      {
        auth_token: JsonWebToken.encode({ user_id: user.id }),
        user: { id: user.id, email: user.email },
        success: true
      }
    end
end
