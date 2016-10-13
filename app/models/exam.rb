class Exam < ActiveRecord::Base
  has_many :topics, dependent: :delete_all
  accepts_nested_attributes_for :topics
end
