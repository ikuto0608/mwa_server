# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class TagsController < ApplicationController
  def search
    term = params[:term]
    @tags = Tag.where("name LIKE ?" , "%#{term}%").to_a
    render json: @tags.to_json
  end
end
