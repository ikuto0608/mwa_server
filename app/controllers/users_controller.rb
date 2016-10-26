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
    @user = User.new(user_params)

    respond_to do |format|
      format.json { render :json => {:success => true, :auth_token => 'hoge'} }
    end
  end

  private
    def user_params
      params.require(:user).permit(:id, :email, :password, :name)
    end
end
