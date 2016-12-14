module Api::V1
  class QuestionsController < ApiController
    before_action :require_login, only: [:create, :edit, :update, :destroy]

    def index
      @questions = QuestionsFilter.new(params).call
      @questions = @questions.page(params[:page])
    end

    def show
      @question = Question.includes(
        :asker,
        :tags,
        :votes,
        :answers,
        :comments,
        :category,
        answers: [:comments, :votes])
          .merge(Comment.order(created_at: :asc))
          .order('answers.created_at')
          .find(params[:id])

      # @vote = @question.votes.find_by(voter_id: current_user.id) if signed_in?
    end

    def create
      @question = current_user.questions.new(question_params)

      if @question.save
        render json: { id: @question.id, slug: @question.slug }
      else
        render json: @question.errors.full_messages,
               status: :unprocessable_entity
      end
    end

    def edit
      @question = current_user.questions.find(params[:id])
    end

    def update
      @question = current_user.questions.find(params[:id])
      if @question.update(question_params)
        render json: { id: @question.id, slug: @question.slug }
      else
        render json: @question.errors.full_messages,
               status: :unprocessable_entity
      end
    end

    def destroy
      @question = current_user.questions.find(params[:id])
      @question.destroy
      render json: {}
    end

    private

    def question_params
      params.require(:question).permit(:title, :description, :description_html, :tag_list, :category_slug)
    end
  end
end
