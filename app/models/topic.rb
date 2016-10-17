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

  def combination_of_answers
    topics = Topic.where(exam_id: self.exam_id).to_a
    answer_array_list = topics.inject([]) {|a, topic| a << topic.answer_array }.uniq
    answer_array_list.delete(self.answer_array)
    [self.answer_array, answer_array_list.sample(3)].shuffle
  end
end
