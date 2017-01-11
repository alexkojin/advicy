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

require 'rails_helper'

RSpec.describe Answer, type: :model do
  it 'is valid with a question, answerer and body' do
    answer = build(:answer)
    expect(answer).to be_valid
  end

  it 'is invalid without a question' do
    answer = build(:answer, question: nil)
    answer.valid?
    expect(answer.errors[:question]).to include("can't be blank")
  end

  it 'is invalid without a answerer' do
    answer = build(:answer, answerer: nil)
    answer.valid?
    expect(answer.errors[:answerer]).to include("can't be blank")
  end

  it 'is invalid without a body' do
    answer = build(:answer, body: '')
    answer.valid?
    expect(answer.errors[:body]).to include("can't be blank")
  end
end
