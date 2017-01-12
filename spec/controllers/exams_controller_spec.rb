require 'rails_helper'

RSpec.describe ExamsController, type: :controller do
  describe "POST #create" do
    context "with valid attributes" do
      it "create new exam" do
        post :create, exam: FactoryGirl.create(:exam_with_topics)
        expect(Exam.count).to eq(1)
      end
    end
  end
end
