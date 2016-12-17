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
    self.property_json['records'] ||= {}
    record_evaluated = self.property_json['records']["#{record.exam_id}"]

    if record_evaluated
      if record.score == 10
        record_evaluated['number_of_current_perfect_in_a_row'] =
          record_evaluated['number_of_current_perfect_in_a_row'] + 1

        record_evaluated['number_of_perfect_in_a_row'] =
          [ record_evaluated['number_of_perfect_in_a_row'],
            record_evaluated['number_of_current_perfect_in_a_row']
          ].max

        record_evaluated['average_perfect_record_time'] =
          ( record_evaluated['average_perfect_record_time'] + record.record_time ) / 2
      else
        record_evaluated['number_of_perfect_in_a_row'] =
          [ record_evaluated['number_of_perfect_in_a_row'],
            record_evaluated['number_of_current_perfect_in_a_row']
          ].max

        record_evaluated['number_of_current_perfect_in_a_row'] = 0
      end
    else
      return unless record.score == 10

      record_evaluated = {
        'number_of_perfect_in_a_row' => 1,
        'number_of_current_perfect_in_a_row' => 1,
        'average_perfect_record_time' => record.record_time,
      }
    end

    self.property_json['records']["#{record.exam_id}"] = record_evaluated
  end
end
