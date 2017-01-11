# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  token      :string(32)       not null, indexed
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :image do
    token "MyString"
    image "MyString"
  end
end
