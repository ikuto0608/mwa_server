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

class Exam < ActiveRecord::Base
  validates_presence_of :name, :user_id, :number_of_answer
  has_many :topics, dependent: :delete_all
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :topics
  accepts_nested_attributes_for :tags
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

  def inject_exsited_tags
    self.tags.load
    new_tags = []
    self.tags.each do |tag|
      if existing = Tag.find_by_name(tag.name)
        new_tags << existing
      else
        new_tags << tag
      end
    end
    self.tags = new_tags
  end
end
