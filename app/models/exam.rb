class Exam < ActiveRecord::Base
  has_many :topics, dependent: :delete_all
  accepts_nested_attributes_for :topics
  serialize :result_array

  def provide

  end

  def mark
    topics = Topic.where(id: [self.result_array.map { |result| result[:topic_id] }]).to_a

    self.result_array.map do |result|
      topic = topics.select {|t| t.id == result[:topic_id] }.first
      result[:correct_answer] = topic.answer_array
      result[:correct_answer] == result[:answer] ? result[:correct] = true : result[:correct] = false
    end
  end
end
