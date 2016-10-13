class Topic < ActiveRecord::Base
  belongs_to :exam
  serialize :questionArray
  serialize :indexArrayOfAnswer
end
