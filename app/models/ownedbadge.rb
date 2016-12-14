class Ownedbadge < ActiveRecord::Base
  validates :owner_id, :badge_id, presence: true

  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  belongs_to :badge, class_name: 'Badge', foreign_key: :badge_id
end

# == Schema Information
#
# Table name: ownedbadges
#
#  id         :integer          not null, primary key
#  owner_id   :integer          not null, indexed
#  badge_id   :integer          not null, indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
