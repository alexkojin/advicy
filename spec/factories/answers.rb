# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  question_id :integer          not null, indexed
#  answerer_id :integer          not null, indexed
#  best        :boolean          default("false")
#  body        :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  score       :integer          default("0"), not null
#  body_html   :text
#

FactoryGirl.define do
  factory :answer do
    question
    association :answerer, factory: :user
    body "I'm good"
  end
end
