class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :commenter, class_name: 'User', foreign_key: 'commenter_id'

  validates :commenter_id, :commentable_type, :commentable_id, :body, presence: true

  def owner?(user)
    user.present? && commenter_id == user.id
  end
end

# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commenter_id     :integer          indexed
#  body             :string
#  commentable_id   :integer          indexed => [commentable_type]
#  commentable_type :string           indexed => [commentable_id]
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
