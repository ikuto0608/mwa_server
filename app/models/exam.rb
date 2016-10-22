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

class Exam < ActiveRecord::Base
  has_many :topics, dependent: :delete_all
  accepts_nested_attributes_for :topics
  serialize :result_array
  serialize :volatile_json, JSON

  attr_reader :marked_topics

  def provide

  end

  def mark
    ids = self.result_array.map { |result| result[:topic_id] }
    @marked_topics = Topic.where(id: ids).index_by(&:id).values_at(*ids).to_a

    @marked_topics.each_with_index do |topic, index|
      topic.volatile_json ||= {}
      topic.volatile_json[:correct] = self.result_array[index][:answer].eql?(topic.answer_array)
      topic.volatile_json[:answer] = self.result_array[index][:answer] unless topic.volatile_json[:correct]
    end
  end
end
