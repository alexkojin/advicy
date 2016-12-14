class JobSkill < ActiveRecord::Base
  belongs_to :skill, inverse_of: :job_skills
  belongs_to :job, inverse_of: :job_skills

  validates :skill, :job, presence: true
  validates :job_id, uniqueness: { scope: :skill_id }
  validates :importance, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }

  accepts_nested_attributes_for :skill
end

# == Schema Information
#
# Table name: job_skills
#
#  id         :integer          not null, primary key
#  skill_id   :integer          not null, indexed => [job_id]
#  job_id     :integer          indexed => [skill_id]
#  importance :integer          default(2), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
