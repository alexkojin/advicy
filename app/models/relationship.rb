class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :following, polymorphic: true

  validates :follower, :following, presence: true
end

# == Schema Information
#
# Table name: relationships
#
#  id             :integer          not null, primary key
#  follower_id    :integer          indexed => [following_type, following_id]
#  following_id   :integer          indexed => [follower_id, following_type]
#  following_type :string           indexed => [follower_id, following_id]
#  created_at     :datetime         not null
#
