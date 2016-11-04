# == Schema Information
#
# Table name: records
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  exam_id                :integer
#  score                  :integer
#  record_time            :integer
#  created_at             :datetime
#  updated_at             :datetime
#  topic_ids              :text
#  wrong_answer_topic_ids :text
#

class Record < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam

  serialize :topic_ids, Array
  serialize :wrong_answer_topic_ids, Array
end
