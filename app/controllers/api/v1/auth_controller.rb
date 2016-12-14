module Api::V1
  class AuthController < ApiController
    def authenticate
      user = AuthenticateUser.new.by_credentials(params[:email], params[:password])
      if user
        render json: authentication_payload(user)
      else
        render json: { errors: ['Invalid username or password'] }, status: :unauthorized
      end
    end

    def facebook_authenticate
      user = AuthenticateUser.new.by_facebook(params[:accessToken])

      if user
        render json: authentication_payload(user)
      else
        render json: { errors: ['Oops! We could not authorize you'] }, status: :unauthorized
      end
    end

    def callback
      logger.info request.env['omniauth.auth']
      render json: request.env['omniauth.auth']
    end

    def failure
      logger.info request.env['omniauth.auth']
      render json: request.env['omniauth.auth']
    end

    private

    def authentication_payload(user)
      return nil unless user && user.id
      {
        id_token: AuthToken.encode({ user_id: user.id }),
        user: { id: user.id, username: user.username, slug: user.slug, image_url: user.image_url }
      }
    end
  end
end
