class AuthenticateUser
  def by_credentials(email, password)
    user = User.find_by(email: email)
    return nil if user.nil?
    user.valid_password?(password) ? user : nil
  end

  def by_omniauth(data)
    user = User.find_by(email: data.info['email'])
    unless user
      user = User.create(
        provider: data.provider,
        uid: data.uid,
        email: data.info['email'],
        name: data.info['name'] || data.info['email'].split("@")[0],
        image_url: data.info['image'],
        password: Devise.friendly_token[0,20])
    end

    user
  end
end



