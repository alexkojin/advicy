class Experience < ActiveRecord::Base
  belongs_to :job, inverse_of: :experiences

  validates :job, presence: true
  validates :experience, presence: true, inclusion: %w(0-1 1-4 4+)
  validates :kind, presence: true, uniqueness: { scope: :job_id }, inclusion: %w(software design)
  validates :importance, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
end

# == Schema Information
#
# Table name: experiences
#
#  id         :integer          not null, primary key
#  job_id     :integer          not null, indexed => [kind]
#  experience :string           not null
#  kind       :string           not null, indexed => [job_id]
#  importance :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
