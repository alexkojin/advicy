class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Support old username
  alias_attribute :username, :name

  paginates_per 20

  has_many :questions, class_name: 'Question', foreign_key: :asker_id, dependent: :destroy
  has_many :answers, class_name: 'Answer', foreign_key: :answerer_id, dependent: :destroy
  has_many :comments, class_name: 'Comment', foreign_key: :commenter_id, dependent: :destroy

  has_many :votes, class_name: 'Vote', foreign_key: :voter_id
  has_many :question_votes, through: :votes, source: :votable
  has_many :answer_votes, through: :votes, source: :votable

  has_many :flags, dependent: :nullify

  has_many :question_points, through: :questions, source: :votes
  has_many :answer_points, through: :answers, source: :votes

  validates :name, presence: true


  def slug
    self.name.parameterize
  end

  # Return url for user's avatar image
  #  @param size [symbol] set size of return image (:default, :thumb)
  def image_url(size = :default)
    if self[:image_url]
      self[:image_url]
    else
      gravatar_id = Digest::MD5::hexdigest(self.email).downcase
      size_param = size == :thumb ? '&s=50' : '&s=200'

      "http://gravatar.com/avatar/#{gravatar_id}.png?d=identicon&r=pg#{size_param}"
    end
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
