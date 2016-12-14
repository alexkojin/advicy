class Connection < ActiveRecord::Base
  include Activities

  belongs_to :company, inverse_of: :connections
  belongs_to :member, polymorphic: true

  validates :company, :member, presence: true
  validates :role, inclusion: %w(employee founder past_investor current_investor incubator advisor attorney board_member customer partner)
  validates :investment_amount, absence: { unless: :current_investor? }, numericality: { greater_than_or_equal_to: 0, if: :current_investor? }
  validates :company_id, uniqueness: { scope: [:role, :member_type, :member_id] }

  def current_investor?
    role == "current_investor"
  end
end

# == Schema Information
#
# Table name: connections
#
#  id                :integer          not null, primary key
#  company_id        :integer          not null, indexed => [role, member_type, member_id]
#  role              :string           not null, indexed => [company_id, member_type, member_id]
#  member_id         :integer          indexed => [company_id, role, member_type]
#  member_type       :string           indexed => [company_id, role, member_id]
#  investment_amount :decimal(8, 2)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
