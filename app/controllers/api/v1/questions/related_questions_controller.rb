module Api::V1
  class Questions::RelatedQuestionsController < ApiController
    def index
      @questions = Question.find(params[:question_id]).find_related_tags.limit(10)
    end
  end
end
