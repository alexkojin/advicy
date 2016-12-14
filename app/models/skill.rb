class Skill < ActiveRecord::Base
  has_many :job_skills, dependent: :delete_all, inverse_of: :skill

  validates :name, presence: true, uniqueness: true

  scope :search, ->(text) {
    where(Skill.arel_table[:name].matches("%#{text}%")) if text.present?
  }
  scope :with_usage, -> {
    constraints = Arel::Nodes::On.new(Skill.arel_table[:id].eq(JobSkill.arel_table[:skill_id]))
    outer_join = Arel::Nodes::OuterJoin.new(JobSkill.arel_table, constraints)
    joins(outer_join).group(:id, :name).select([
      Skill.arel_table[:id],
      Skill.arel_table[:name],
      Skill.arel_table[:created_at],
      Skill.arel_table[:updated_at],
      Arel::Nodes::NamedFunction.new("COUNT", [JobSkill.arel_table[:id]]).as("job_skills_count")
    ]).order('job_skills_count DESC', :name)
  }
end

# == Schema Information
#
# Table name: skills
#
#  id         :integer          not null, primary key
#  name       :string           not null, indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
