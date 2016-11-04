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

require 'test_helper'

class RecordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
