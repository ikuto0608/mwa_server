class Topic < ActiveRecord::Base
  belongs_to :exam
  serialize :question_array
  serialize :index_array_of_answer

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
