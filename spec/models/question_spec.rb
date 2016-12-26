require 'rails_helper'

RSpec.describe Question, type: :model do
  it 'is valid with a title, asker and category' do
    question = Question.new(
      title: 'Who are you?',
      description: 'Bla-bla-blah Bla-Bla-Bla-blah Bla-Bla Blah',
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

  it 'is invalid without description' do
    question = build(:question, description: '')
    question.valid?
    expect(question.errors[:description]).to include("can't be blank")
  end
end
