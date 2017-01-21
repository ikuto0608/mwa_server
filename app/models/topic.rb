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

class Topic < ActiveRecord::Base
  validates_presence_of :question, :question_array, :index_array_of_answer, :user_id
  belongs_to :exam
  serialize :question_array
  serialize :index_array_of_answer
  serialize :volatile_json, JSON

  def make_question
    question_array.each_with_index.inject("") do |str, (q, index)|
      q = "(　　)" if index_array_of_answer.include?(index)
      str += q + " "
    end
  end

  def answer_array
    index_array_of_answer.inject([]) {|a, index| a << question_array[index] }
  end
end
