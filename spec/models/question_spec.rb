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

require 'rails_helper'

RSpec.describe Question, type: :model do
  it 'is valid with a title, asker' do
    question = Question.new(
      title: 'Who are you?',
      description: 'Bla-bla-blah Bla-Bla-Bla-blah Bla-Bla Blah',
      asker: create(:user))

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

  it 'is invalid without description' do
    question = build(:question, description: '')
    question.valid?
    expect(question.errors[:description]).to include("can't be blank")
  end
end
