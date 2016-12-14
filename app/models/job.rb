class Job < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  belongs_to :company
  has_many :experiences, dependent: :delete_all, inverse_of: :job
  has_many :educations, dependent: :delete_all, inverse_of: :job
  has_many :job_skills, dependent: :delete_all, inverse_of: :job
  has_many :skills, through: :job_skills
  belongs_to :primary_role, class_name: "Role", inverse_of: :primary_jobs
  has_many :job_roles, dependent: :delete_all, inverse_of: :job
  has_many :roles, through: :job_roles

  accepts_nested_attributes_for :company
  accepts_nested_attributes_for :educations, allow_destroy: true
  accepts_nested_attributes_for :experiences, allow_destroy: true
  accepts_nested_attributes_for :job_skills, allow_destroy: true

  attr_accessor :terms_of_service

  validates :company, presence: true
  validates :owner, presence: true
  validates :title, presence: true, uniqueness: true
  validates :primary_role, presence: true
  validates :job_type, presence: true, inclusion: %w(full_time contract internship cofounder)
  validates :location, presence: true
  validates :salary_min, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 108_089 }
  validates :salary_max, presence: true, numericality: { greater_than_or_equal_to: ->(job) { job.salary_min || 0 }, less_than_or_equal_to: 108_089 }
  validates :currency, presence: true, inclusion: %w(USD EUR GBP CAD JPY CNY INR SGD)
  validates :equity_min, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :equity_max, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :equity_vest, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :equity_cliff, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :notify_phone_code, numericality: { only_integer: true, allow_blank: true }
  validate :check_equity_range
  validates :terms_of_service, acceptance: true, if: :new_record?
  validate :job_and_company_should_have_same_owner, if: :new_record?

  def check_equity_range
    errors.add(:equity, "range must be within 15%") if (equity_max.to_f - equity_min.to_f) > 15.0
  end

  def job_and_company_should_have_same_owner
    errors.add(:base, "different owners") if company.owner != owner
  end
end

# == Schema Information
#
# Table name: jobs
#
#  id                   :integer          not null, primary key
#  owner_id             :integer          not null, indexed
#  company_id           :integer          not null, indexed
#  title                :string           not null, indexed
#  description          :text
#  job_type             :string           default("full-time"), not null
#  location             :string           not null
#  coworkers            :string
#  remote               :boolean          default(FALSE)
#  international        :boolean          default(FALSE)
#  salary_min           :decimal(8, 2)    not null
#  salary_max           :decimal(8, 2)    not null
#  currency             :string           default("USD"), not null
#  equity_min           :integer          not null
#  equity_max           :integer          not null
#  equity_vest          :decimal(8, 2)    default(4.0), not null
#  equity_cliff         :decimal(8, 2)    default(1.0), not null
#  notify_email         :boolean          default(TRUE)
#  notify_phone_code    :integer
#  notify_phone         :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  notify_phone_country :string(2)        default("us"), not null
#  primary_role_id      :integer          not null
#
