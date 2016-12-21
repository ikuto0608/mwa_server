# == Schema Information
#
# Table name: ranks
#
#  id                                 :integer          not null, primary key
#  user_id                            :integer
#  exam_id                            :integer
#  number_of_perfect_in_a_row         :integer
#  number_of_current_perfect_in_a_row :integer
#  average_perfect_record_time        :float
#  created_at                         :datetime
#  updated_at                         :datetime
#  user_name                          :string(255)
#

class Rank < ActiveRecord::Base
end
