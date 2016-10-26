# == Schema Information
#
# Table name: topics
#
#  id                    :integer          not null, primary key
#  question              :string(255)
#  question_array        :text
#  index_array_of_answer :text
#  user_id               :integer
#  created_at            :datetime
#  updated_at            :datetime
#  exam_id               :integer
#  volatile_json         :text
#  description           :text
#

require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end
