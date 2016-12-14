module Api::V1
  class AnswersController < ApiController
    before_action :require_login, only: [:create, :edit, :update, :destroy]
    before_action :load_answer, only: [:edit, :update, :destroy]

    def create
      @answer = current_user.answers.new(answer_params)

      if @answer.save
        render :create
      else
        render json: @answer.errors.full_messages, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @answer.update_attributes(answer_params)
        render :create
      else
        render json: @answer.errors.full_messages, status: :unprocessable_entity
      end
    end

    def destroy
      @answer.destroy
      render json: {}
    end

    private

    def answer_params
      params.require(:answer).permit(:question_id, :body, :body_html, :best)
    end

    def load_answer
      @answer = current_user.answers.find(params[:id])
    end
  end
end
