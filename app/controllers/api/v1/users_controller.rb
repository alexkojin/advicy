module Api::V1
  class UsersController < ApiController
    def index
      @users = User.includes(:questions, :answers, :comments, :votes)
      if params[:query]
        @users = @users.where('LOWER(name) LIKE (?)', "%#{params[:query]}%")
      end

      @users = @users.page(params[:page])
    end

    def show
      @user = User.includes(:questions, :answers, :comments, :votes)
              .find(params[:id])
    end

    def create
      user = User.new(user_params)
      user.password_confirmation = user.password

      if user.save
        render json: {
          user: { id: user.id, username: user.username, slug: user.slug, image_url: user.image_url }
        }
      else
        render json: { errors: user.errors.full_messages.join(' ') }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
  end
end
