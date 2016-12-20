class RanksController < ApplicationController
  before_filter :authenticate_request!
  respond_to :json

  def find_by_exam
    return if @current_user.nil?

    @ranks = Rank.where(exam_id: params[:exam_id]).to_a
    render :json => @ranks.to_json
  end
end
