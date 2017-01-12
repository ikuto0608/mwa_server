require 'rails_helper'

RSpec.describe Record, type: :model do
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:exam_id) }
  it { is_expected.to validate_presence_of(:score) }
  it { is_expected.to validate_presence_of(:record_time) }
  it { is_expected.to validate_presence_of(:topic_ids) }
  it { is_expected.to validate_presence_of(:wrong_answer_topic_ids) }
end
