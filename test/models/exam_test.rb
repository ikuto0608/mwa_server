# == Schema Information
#
# Table name: exams
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  user_id       :integer
#  category_id   :integer
#  created_at    :datetime
#  updated_at    :datetime
#  result_array  :text
#  result_time   :integer
#  volatile_json :text
#

require 'test_helper'

class ExamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
