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
#  property_json          :text             default("{}")
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :records, dependent: :delete_all
  serialize :property_json, JSON

  def update_record(record)
    rank = Rank.where(user_id: self.id, exam_id: record.exam_id).first

    if rank.nil?
      return unless record.score == 10

      rank = Rank.new(user_id: self.id, exam_id: record.exam_id, user_name: self.name)
      rank.number_of_perfect_in_a_row = 1
      rank.number_of_current_perfect_in_a_row = 1
      rank.average_perfect_record_time = record.record_time
    else
      if record.score == 10
        rank.number_of_current_perfect_in_a_row += 1
        rank.number_of_perfect_in_a_row =
          [rank.number_of_perfect_in_a_row, rank.number_of_current_perfect_in_a_row].max

        rank.average_perfect_record_time =
          ( rank.average_perfect_record_time + record.record_time ) / 2
      else
        rank.number_of_current_perfect_in_a_row = 0
      end
    end

    rank.save
  end
end
