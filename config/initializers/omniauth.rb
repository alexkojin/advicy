Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :github,        ENV['GITHUB_KEY'],   ENV['GITHUB_SECRET'],   scope: 'email,profile'
  provider :facebook,      ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], image_size: 'large'
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'],   ENV['GOOGLE_CLIENT_SECRET']
end
