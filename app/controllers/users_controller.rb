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
  before_filter :authenticate_request!, :only => :show

  def show
    unless @current_user.nil?
      respond_to do |format|
        format.json { render :json => { name: @current_user.name, email: @current_user.email } }
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:id, :email, :password, :name)
    end
end
