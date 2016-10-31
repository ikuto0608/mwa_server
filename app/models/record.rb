# == Schema Information
#
# Table name: records
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  exam_id                :integer
#  score                  :integer
#  record_time            :integer
#  topic_ids              :string(255)
#  wrong_answer_topic_ids :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class Record < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam

  serialize :topic_ids, Array
  serialize :wrong_answer_topic_ids, Array
end
