class Question < ActiveRecord::Base
  paginates_per 10
  acts_as_taggable

  belongs_to :asker, class_name: 'User', foreign_key: :asker_id
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :views, as: :viewable, dependent: :delete_all
  has_many :answers, class_name: 'Answer',
                     foreign_key: :question_id,
                     dependent: :destroy

  belongs_to :category

  validates :title, :asker, :category, presence: true

  scope :unanswered, -> { where('questions.answers_count = 0') }
  # currently it's simplified and retrieve most viewed questions
  # more about calculation popular here:
  #  http://meta.stackexchange.com/questions/11602/what-formula-should-be-used-to-determine-hot-questions
  scope :popular, -> { order('questions.views_count DESC, questions.created_at DESC') }
  scope :last_week, -> { where('questions.created_at > ?', 7.days.ago) }
  scope :last_month, -> { where('questions.created_at > ?', 30.days.ago) }

  def slug
    self.title.parameterize
  end

  def owner?(user)
    user.present? && asker_id == user.id
  end

  def category_slug
    self.category && self.category.slug
  end

  def category_slug=(value)
    self.category = value.blank? ? nil : Category.find_by(slug: value)
  end
end

# == Schema Information
#
# Table name: questions
#
#  id               :integer          not null, primary key
#  asker_id         :integer          not null, indexed
#  title            :string           not null, indexed
#  description      :text
#  views_count      :integer          default(0), not null
#  created_at       :datetime         not null, indexed => [answers_count]
#  updated_at       :datetime         not null
#  category_id      :integer          not null
#  score            :integer          default(0), not null
#  description_html :text
#  answers_count    :integer          default(0), not null, indexed => [created_at]
#
