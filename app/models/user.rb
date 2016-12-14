class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Support old username
  alias_attribute :username, :name

  DEFAULT_IMAGE_URL = 'http://res.cloudinary.com/charliecloud/image/upload/v1434941598/logo_cqo72p.png'

  paginates_per 20

  has_many :questions, class_name: 'Question', foreign_key: :asker_id, dependent: :destroy
  has_many :answers, class_name: 'Answer', foreign_key: :answerer_id, dependent: :destroy
  has_many :comments, class_name: 'Comment', foreign_key: :commenter_id, dependent: :destroy
  has_many :owned_badges, class_name: 'Ownedbadge', foreign_key: :owner_id, dependent: :destroy

  has_many :badges, through: :owned_badges, source: :badge

  has_many :votes, class_name: 'Vote', foreign_key: :voter_id
  has_many :question_votes, through: :votes, source: :votable
  has_many :answer_votes, through: :votes, source: :votable

  has_many :flags, dependent: :nullify

  has_many :question_points, through: :questions, source: :votes
  has_many :answer_points, through: :answers, source: :votes

  has_many :companies, dependent: :destroy, foreign_key: :owner_id
  has_many :jobs, dependent: :destroy, foreign_key: :owner_id


  def slug
    self.name.parameterize
  end

  def image_url
    self[:image_url] || DEFAULT_IMAGE_URL
  end

  def points
    answer_points_total + question_points_total
  end

  def answer_points_total
    answer_points.inject(0) { |total, vote| total += vote.value }
  end

  def question_points_total
    question_points.inject(0) { |total, vote| total += vote.value }
  end

  def award_badges
    Badge.all.each do |badge|
      if badge.value <= self.points && !self.badges.include?(badge)
        self.owned_badges.create(badge_id: badge.id)
      end
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null, indexed
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  image_url              :string
#  uid                    :string           default(""), not null
#  provider               :string           default("email"), not null
#  reset_password_token   :string           indexed
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
