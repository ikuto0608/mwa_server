# == Schema Information
#
# Table name: exams
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  user_id          :integer
#  category_id      :integer
#  created_at       :datetime
#  updated_at       :datetime
#  result_array     :text
#  result_time      :integer
#  volatile_json    :text
#  number_of_answer :integer
#  description      :text
#

require 'test_helper'

class ExamsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end
