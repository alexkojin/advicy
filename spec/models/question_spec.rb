require 'rails_helper'

RSpec.describe Question, type: :model do
  it 'is valid with a title, asker and category' do
    question = build(:question,
      title: 'Who are you?',
      asker: create(:user),
      category: create(:category))

    expect(question).to be_valid
  end

  it 'is invalid without title' do
    question = build(:question, title: nil)
    question.valid?
    expect(question.errors[:title]).to include("can't be blank")
  end

  it 'is invalid without asker' do
    question = build(:question, asker: nil)
    question.valid?
    expect(question.errors[:asker]).to include("can't be blank")
  end

  it 'is invalid without category' do
    question = build(:question, category: nil)
    question.valid?
    expect(question.errors[:category]).to include("can't be blank")
  end
end
