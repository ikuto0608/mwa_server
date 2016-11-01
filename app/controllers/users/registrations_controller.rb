class Users::RegistrationsController < Devise::RegistrationsController
  # POST /resource
  def create
    super do |user|
      render json: payload(user) and return
    end
  end

  private
    def user_params
      params.require(:registration).permit(:email, :password, :password_confirmation, :name)
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
