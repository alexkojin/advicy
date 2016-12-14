  class AuthController < ApplicationController
    # After Omniauth got data from oauth service
    # Register or sigin an user
    # Send jwt-token to client app to oauth-complete component
    #   that will save it and redirect back url
    def callback
      user = AuthenticateUser.new.by_omniauth(request.env['omniauth.auth'])
      query = if user.id
        {
          id_token: AuthToken.encode({ user_id: user.id }),
          user_id: user.id,
          username: user.username,
          slug: user.slug,
          image_url: user.image_url
        }
      else
        {
          error: true
        }
      end

      redirect_to "#{ENV['APP_URL']}/oauth-complete?#{query.to_query}"
    end

    def failure
      # logger.info request.env['omniauth.auth']
      render json: request.env['omniauth.auth']
    end
  end


