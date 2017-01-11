# == Schema Information
#
# Table name: questions
#
#  id               :integer          not null, primary key
#  asker_id         :integer          not null, indexed
#  title            :string           not null, indexed
#  description      :text
#  views_count      :integer          default("0"), not null
#  created_at       :datetime         not null, indexed => [answers_count]
#  updated_at       :datetime         not null
#  score            :integer          default("0"), not null
#  description_html :text
#  answers_count    :integer          default("0"), not null, indexed => [created_at]
#

FactoryGirl.define do
  factory :question do
    association :asker, factory: :user
    title 'How are you?'
    description "What are others versions of this questions do you know?"
  end
end
