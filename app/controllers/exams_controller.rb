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

  def create
    @exam = Exam.new(exam_params)
    @exam.save()

    respond_to do |format|
      format.json { render :json => {:message => "Success"} }
    end
  end

  def exam_params
    #params.require(:exam).(:name, :userId, :categoryId, topics_attributes: [ :question, :questionArray, :indexArrayOfAnswer, :userId, :examId ])
    params.require(:exam).permit(:name, topics_attributes: [ :question, questionArray: [], indexArrayOfAnswer: [] ])
  end
end
