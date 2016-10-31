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

require 'test_helper'

class RecordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
