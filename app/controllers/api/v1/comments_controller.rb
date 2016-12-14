module Api::V1
  class CommentsController < ApiController
    before_action :require_login

    def create
      @commentable = find_commentable
      @comment = @commentable.comments.build(comment_params)
      @comment.commenter_id = current_user.id

      if @comment.save
        render :create
      else
        render json: @comment.errors.full_messages, status: :unprocessable_entity
      end
    end

    def destroy
      @comment = current_user.comments.find(params[:id])
      @comment.destroy
      render json: {}
    end

    def update
      @comment = current_user.comments.find(params[:id])

      if @comment.update_attributes(comment_params)
        render json: @comment
      else
        render json: @comment.errors.full_messages, status: :unprocessable_entity
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def find_commentable
      case params[:comment][:commentable_type]
      when 'question'
        Question.find(params[:comment][:commentable_id])
      when 'answer'
        Answer.find(params[:comment][:commentable_id])
      else
        raise ActiveRecord::RecordNotFound
      end
    end
  end
end
