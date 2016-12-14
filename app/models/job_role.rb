class JobRole < ActiveRecord::Base
  belongs_to :job, inverse_of: :job_roles
  belongs_to :role, inverse_of: :job_roles

  validates :job, presence: true
  validates :role, presence: true
  validates :role_id, uniqueness: { scope: :job_id }
end

# == Schema Information
#
# Table name: job_roles
#
#  id         :integer          not null, primary key
#  job_id     :integer          not null, indexed => [role_id]
#  role_id    :integer          not null, indexed => [job_id]
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
