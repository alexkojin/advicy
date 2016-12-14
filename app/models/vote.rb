class Vote < ActiveRecord::Base
  validates :voter_id, :value, :votable_type, :votable_id, presence: true
  validates :voter_id, uniqueness: { scope: [:votable_id, :votable_type] }

  belongs_to :votable, polymorphic: true
  belongs_to :voter, class_name: 'User', foreign_key: 'voter_id'

  validates :value, inclusion: { in: [-1, 1] }

  after_save :update_votable_score
  after_destroy :update_votable_score

  def update_votable_score
    # TODO replace it by one sql
    votable.update_attribute(:score, votable.votes.sum(:value))
  end
end

# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  voter_id     :integer          indexed
#  value        :integer
#  votable_id   :integer          indexed => [votable_type]
#  votable_type :string           indexed => [votable_id]
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
