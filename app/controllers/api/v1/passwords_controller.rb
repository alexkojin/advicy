module Api::V1
  class PasswordsController < ApiController
    def create
      user = User.send_reset_password_instructions(email: params[:email])

      if user.errors.blank?
        render json: {}
      else
        render json: user.errors.full_messages, status: :unprocessable_entity
      end
    end

    def update
      options = params.slice(:reset_password_token, :password, :password_confirmation)
      user = User.reset_password_by_token(options)

      if user.errors.blank?
        render json: {}
      else
        render json: user.errors.full_messages, status: :unprocessable_entity
      end
    end
  end
end
