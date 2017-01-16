module AuthHelpers
  def let_auth_headers
    let(:auth_headers) do
      user = FactoryGirl.create(:user)
      id_token = AuthToken.encode({ user_id: user.id })
      { "Authorization" => "Bearer #{id_token}" }
    end
  end
end
