FactoryGirl.define do
  factory :answer do
    question
    association :answerer, factory: :user
    body "I'm good"
  end
end
