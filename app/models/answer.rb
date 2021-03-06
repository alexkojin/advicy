class Answer < ActiveRecord::Base
  belongs_to :answerer, class_name: 'User', foreign_key: :answerer_id
  belongs_to :question, counter_cache: true

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  validates :question, :answerer, :body, presence: true

  def owner?(user)
    user.present? && answerer_id == user.id
  end
end

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
