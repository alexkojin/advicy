require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name, email, password and password confirmation' do
    user = build(:user, name: 'Alex', email: 'alex@example.com',
      password: 'qwe12345', password_confirmation: 'qwe12345')
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without an email' do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid without a password' do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email' do
    create(:user, email: 'dup@example.com')
    user = build(:user, email: 'dup@example.com')
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
end
