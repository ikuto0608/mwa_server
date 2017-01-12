# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
  validates_presence_of :name
  has_and_belongs_to_many :exams
  validates :name, uniqueness: true
end
