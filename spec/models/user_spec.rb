# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null, indexed
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  image_url              :string
#  uid                    :string           default(""), not null
#  provider               :string           default("email"), not null
#  reset_password_token   :string           indexed
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

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
