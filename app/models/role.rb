class Role < ActiveRecord::Base
  has_many :primary_jobs, class_name: "Job", inverse_of: :primary_role
  has_many :job_roles, inverse_of: :role

  validates :name, presence: true
  validates :category, presence: true, uniqueness: { scope: :name }
end

# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string           not null, indexed => [category]
#  category   :string           not null, indexed => [name]
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
