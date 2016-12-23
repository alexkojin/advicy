FactoryGirl.define do
  factory :question do
    association :asker, factory: :user
    category
    title 'How are you?'
  end
end
