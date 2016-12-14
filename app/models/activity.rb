class Activity < ActiveRecord::Base
  belongs_to :trackable, polymorphic: true
  belongs_to :actor, polymorphic: true
  belongs_to :recipient, polymorphic: true

  serialize :parameters

  validates :key, :trackable, :actor, :recipient, presence: true
end

# == Schema Information
#
# Table name: activities
#
#  id             :integer          not null, primary key
#  trackable_id   :integer          indexed => [trackable_type]
#  trackable_type :string           indexed => [trackable_id]
#  actor_id       :integer          indexed => [actor_type]
#  actor_type     :string           indexed => [actor_id]
#  key            :string
#  parameters     :text
#  recipient_id   :integer          indexed => [recipient_type]
#  recipient_type :string           indexed => [recipient_id]
#  created_at     :datetime         not null
#
