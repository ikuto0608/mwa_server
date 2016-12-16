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
  before_filter :authenticate_request!
  respond_to :json

  def index
    @exams = Exam.all()
    render :json => @exams.to_json(:include => [:tags])
  end

  def show
    id = params[:id]
    @exam = Exam.where(id: id).first

    render json: {
                  id: @exam.id,
                  name: @exam.name,
                  description: @exam.description,
                  userId: @exam.user_id,
                  numberOfAnswer: @exam.number_of_answer,
                  topics: @exam.topics,
                  tags: @exam.tags,
                }.to_json
  end

  def find_by_user
    return if @current_user.nil?

    @exams = Exam.where(user_id: @current_user.id).to_a
    render :json => @exams.to_json(:include => [:tags])
  end

  def search
    tags = params[:tag].split(',')
    @exams = Exam.joins(:tags).where(:tags => {name: tags}).uniq.to_a
    render :json => @exams.to_json(:include => [:tags])
  end

  def searchByTag
    term = params[:term]
    @exams = Exam.joins(:tags).where("tags.name LIKE ?" , "%#{term}%").uniq.to_a
    render json: @exams.to_json(:include => [:tags])
  end

  def create
    return if @current_user.nil?

    @exam = Exam.new(exam_params)
    @exam.inject_exsited_tags
    @exam.user_id = @current_user.id

    if @exam.save()
      render :json => { :message => "Success" }
    else
      render :json => { :message => "Error" }
    end
  end

  def update
    return if @current_user.nil?

    @exam = Exam.where(id: params[:id]).first
    @exam.assign_attributes(exam_params)
    @exam.inject_exsited_tags

    if @exam.save()
      render :json => { :message => "Success" }
    else
      render :json => { :message => "Error" }
    end
  end

  def take
    return if @current_user.nil?

    id = params[:id]
    @exam = Exam.where(id: id).first

    topics = @exam.topics.to_a
    answer_array_list = topics.inject([]) {|a, topic| a << topic.answer_array }.uniq
    question_array = []

    topics.sample(10).each do |topic|
      answer_array_list.delete(topic.answer_array)
      question_array << {
                          id: topic.id,
                          answers: [topic.answer_array].concat(answer_array_list.sample(3)).shuffle,
                          sentence: topic.make_question,
                          description: topic.description
                        }
      answer_array_list << topic.answer_array
    end

    render json: { id: @exam.id, name: @exam.name, questions: question_array }.to_json
  end

  def result
    return if @current_user.nil?
    
    @exam = Exam.new(exam_params)
    @exam.mark

    topics = []
    @exam.marked_topics.each do |topic|
      topics << {
                  question: topic.question,
                  description: topic.description,
                  questionArray: topic.question_array,
                  indexArrayOfAnswer: topic.index_array_of_answer,
                  userId: topic.user_id,
                  examId: topic.exam_id,
                  volatileJson: topic.volatile_json
                }
    end

    record = Record.new(exam_id: @exam.id, user_id: @current_user.id)
    record.record_time = @exam.result_time
    record.topic_ids = @exam.marked_topics.map(&:id)
    record.wrong_answer_topic_ids = @exam.marked_topics.map do |topic|
      topic.id unless topic.volatile_json[:correct]
    end
    record.wrong_answer_topic_ids.compact!
    record.score = record.topic_ids.count - record.wrong_answer_topic_ids.count
    record.save

    render json: { id: @exam.id, name: @exam.name, resultTime: @exam.result_time, markedTopics: topics }.to_json
  end

  private
    def exam_params
      params.require(:exam).permit(:id, :name, :number_of_answer, :description, :result_time, tags_attributes: [ :name ], topics_attributes: [ :question, :description, question_array: [], index_array_of_answer: [] ], result_array: [:topic_id, answer: []])
    end
end
