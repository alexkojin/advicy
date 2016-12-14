module Api::V1
  class AccessDeniedError < StandardError; end
  class NotAuthenticatedError < StandardError; end
  class AuthenticationTimeoutError < StandardError; end

  class ApiController < ActionController::API
    helper_method :current_user, :signed_in?

    # When an error occurs, respond with the proper private method below
    rescue_from AuthenticationTimeoutError, with: :authentication_timeout
    rescue_from NotAuthenticatedError, with: :user_not_authenticated

    protected

    def current_user
      @current_user ||= if user_id_included_in_auth_token?
        User.find_by(id: decoded_auth_token[:user_id])
      else
        nil
      end
    end

    # This method gets the current user based on the user_id included
    # in the Authorization header (json web token).
    #
    # Call this from child controllers in a before_action or from
    # within the action method itself
    def authenticate_request!
      fail NotAuthenticatedError unless user_id_included_in_auth_token?
      @current_user = User.find(decoded_auth_token[:user_id])
    rescue JWT::ExpiredSignature
      raise AuthenticationTimeoutError
    rescue JWT::VerificationError, JWT::DecodeError
      raise NotAuthenticatedError
    end

    alias_method :require_login, :authenticate_request!

  private

    # Authentication Related Helper Methods
    # ------------------------------------------------------------
    def user_id_included_in_auth_token?
      http_auth_token && decoded_auth_token && decoded_auth_token[:user_id]
    end

    # Decode the authorization header token and return the payload
    def decoded_auth_token
      @decoded_auth_token ||= AuthToken.decode(http_auth_token)
    end

    # Raw Authorization Header token (json web token format)
    # JWT's are stored in the Authorization header using this format:
    # Bearer somerandomstring.encoded-payload.anotherrandomstring
    def http_auth_token
      @http_auth_token ||= if request.headers['Authorization'].present?
                             request.headers['Authorization'].split(' ').last
                           end
    end

    # Helper Methods for responding to errors
    # ------------------------------------------------------------
    def authentication_timeout
      render json: { errors: ['Authentication Timeout'] }, status: 419
    end

    def forbidden_resource
      render json: { errors: ['Not Authorized To Access Resource'] }, status: :forbidden
    end

    def user_not_authenticated
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end
  end
end