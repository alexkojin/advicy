class Category < ActiveRecord::Base
  has_many :questions, dependent: :nullify

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  before_validation do
    self.slug ||= name.parameterize unless name.blank?
  end

  scope :with_counts, -> {
    joins("LEFT JOIN questions ON categories.id = questions.category_id").
      select("categories.*, COUNT(questions.id) AS questions_count").
      group("categories.id").
      order("questions_count DESC")
  }

  def to_param
    slug
  end
end

# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string           not null, indexed
#  slug       :string           not null, indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
