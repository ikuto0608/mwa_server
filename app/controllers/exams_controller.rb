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
      question_array << { id: topic.id, answers: [topic.answer_array].concat(answer_array_list.sample(3)), sentence: topic.make_question }
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

    respond_to do |format|
      format.json do
        render json: { id: @exam.id, name: @exam.name, result_array: @exam.result_array }.to_json
      end
    end
  end

  def exam_params
    params.require(:exam).permit(:id, :name, topics_attributes: [ :question, question_array: [], index_array_of_answer: [] ], result_array: [:topic_id, answer: []])
  end
end
