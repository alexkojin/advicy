FactoryGirl.define do
  factory :question do
    association :asker, factory: :user
    title 'How are you?'
    description "What are others versions of this questions do you know?"
  end
end
