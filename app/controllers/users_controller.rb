# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

class UsersController < ApplicationController
  before_filter :authenticate_request!, :only => [:show, :latest_history]

  def show
    return if @current_user.nil?

    exam_ids = @current_user.records.map(&:exam_id).uniq
    exams = Exam.where(id: exam_ids).to_a
    render json: { user: @current_user, exams: exams }.to_json
  end

  def latest_history
    return if @current_user.nil?

    records = Record.where(user_id: @current_user.id, exam_id: params[:exam_id])
                    .order(created_at: :desc)
                    .to_a

    latest_records = records[0..9]
    average_score = records.sum(&:score) / records.count.to_f
    average_record_time = records.sum(&:record_time) / records.count.to_f

    render json: {
                  latestRecords: latest_records,
                  averageScore: average_score.round(1),
                  averageRecordTime: average_record_time.round(0),
                 }.to_json
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name)
    end
end
