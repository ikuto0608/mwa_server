require 'rails_helper'

RSpec.describe Rank, type: :model do
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:exam_id) }
  it { is_expected.to validate_presence_of(:user_name) }
end
