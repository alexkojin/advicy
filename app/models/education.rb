class Education < ActiveRecord::Base
  belongs_to :job, inverse_of: :educations

  validates :job, presence: true
  validates :kind, presence: true, uniqueness: { scope: :job_id }, inclusion: %w(software design)
  validates :importance, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
end

# == Schema Information
#
# Table name: educations
#
#  id         :integer          not null, primary key
#  job_id     :integer          not null, indexed => [kind]
#  kind       :string           not null, indexed => [job_id]
#  importance :integer          default(2), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
