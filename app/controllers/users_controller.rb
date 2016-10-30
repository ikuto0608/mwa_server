# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  name       :string(255)
#  password   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class UsersController < ApplicationController
  def login
    @user = User.where(email: user_params[:email]).first
    if @user.nil?
      respond_to do |format|
        format.json { render :json => { :success => false } }
      end

      return
    end

    if !(@user.password == user_params[:password])
      respond_to do |format|
        format.json { render :json => { :success => false } }
      end

      return
    end

    respond_to do |format|
      format.json { render :json => { :success => true, :auth_token => @user.auth_token } }
    end
  end

  private
    def user_params
      params.require(:user).permit(:id, :email, :password, :name)
    end
end
