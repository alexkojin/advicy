class Flag < ActiveRecord::Base
  FLAG_TYPES = %w(spam rude low_quality duplicate)

  belongs_to :user
  belongs_to :flaggable, polymorphic: true

  validates :flag_type, inclusion: { in: FLAG_TYPES }, presence: true
end

# == Schema Information
#
# Table name: flags
#
#  id             :integer          not null, primary key
#  user_id        :integer          indexed => [flaggable_id, flaggable_type]
#  flaggable_id   :integer          indexed => [flaggable_type], indexed => [user_id, flaggable_type]
#  flaggable_type :string           indexed => [flaggable_id], indexed => [user_id, flaggable_id]
#  flag_type      :string
#  reason         :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
