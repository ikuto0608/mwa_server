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

class ExamsController < ApplicationController
  def index
    @exams = Exam.all()
    @exams.each do |exam|
      exam.topics
    end

    respond_to do |format|
      format.json do
        render json: @exams.to_json
      end
    end
  end

  def show
    id = params[:id]
    @exam = Exam.where(id: id).first

    respond_to do |format|
      format.json do
        render json: @exam.to_json(:include => :topics)
      end
    end
  end

  def create
    @exam = Exam.new(exam_params)
    @exam.save()

    respond_to do |format|
      format.json { render :json => {:message => "Success"} }
    end
  end

  def take
    id = params[:id]
    @exam = Exam.where(id: id).first

    topics = @exam.topics.to_a
    answer_array_list = topics.inject([]) {|a, topic| a << topic.answer_array }.uniq
    question_array = []

    topics.sample(10).each do |topic|
      answer_array_list.delete(topic.answer_array)
      question_array << { id: topic.id, answers: [topic.answer_array].concat(answer_array_list.sample(3)).shuffle, sentence: topic.make_question, description: topic.description }
      answer_array_list << topic.answer_array
    end

    respond_to do |format|
      format.json do
        render json: { id: @exam.id, name: @exam.name, questions: question_array }.to_json
      end
    end
  end

  def result
    @exam = Exam.new(exam_params)
    @exam.mark

    topics = []
    @exam.marked_topics.each do |topic|
      topics << {question: topic.question, description: topic.description, questionArray: topic.question_array, indexArrayOfAnswer: topic.index_array_of_answer, userId: topic.user_id, examId: topic.exam_id, volatileJson: topic.volatile_json }
    end

    respond_to do |format|
      format.json do
        render json: { id: @exam.id, name: @exam.name, markedTopics: topics }.to_json
      end
    end
  end

  private
    def exam_params
      params.require(:exam).permit(:id, :name, :result_time, topics_attributes: [ :question, :description, question_array: [], index_array_of_answer: [] ], result_array: [:topic_id, answer: []])
    end
end
