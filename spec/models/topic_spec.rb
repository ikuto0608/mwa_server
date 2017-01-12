require 'rails_helper'

RSpec.describe Topic, type: :model do
  it { is_expected.to validate_presence_of(:question) }
  it { is_expected.to validate_presence_of(:question_array) }
  it { is_expected.to validate_presence_of(:index_array_of_answer) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:exam_id) }
end
