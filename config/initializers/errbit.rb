Airbrake.configure do |config|
  config.host = 'https://errbit-notification.herokuapp.com'
  config.project_id = 3
  config.project_key = 'd826daf267cd6c405461306e51daeb7a'

  config.root_directory = Rails.root
  config.logger = Rails.logger
  config.environment = Rails.env
  config.ignore_environments = %w(development test)

  config.blacklist_keys = [/password/i]
end

Airbrake.add_filter do |notice|
  ignore_exceptions = %w(ActiveRecord::RecordNotFound ActionController::RoutingError)

  if notice[:errors].any? { |error| ignore_exceptions.include?(error[:type]) }
    notice.ignore!
  end
end
