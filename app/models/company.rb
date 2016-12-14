class Company < ActiveRecord::Base
  include Activities

  belongs_to :owner, class_name: "User"
  has_many :relationships, as: :following, dependent: :delete_all
  has_many :followers, through: :relationships
  has_many :connections, inverse_of: :company, dependent: :delete_all
  has_many :members, through: :connections

  validates :owner, presence: true
  validates :name, presence: true, uniqueness: { scope: :owner_id }
  validates :role, presence: true, inclusion: %w(employee founder)
  # validates :logo, presence: true
  validates :website, presence: true
  validates :location, presence: true
  validates :markets, presence: true
  validates :size, presence: true, inclusion: %w(1-10 11-50 51-200 201-500 501-1000 1001-5000 5000+)
  validates :pitch, presence: true

  mount_uploader :logo, LogoUploader

  after_create :add_activity_on_create

  protected

  def add_activity_on_create
    create_activity(key: :created, actor: owner, recipient: owner)
  end
end

# == Schema Information
#
# Table name: companies
#
#  id           :integer          not null, primary key
#  owner_id     :integer          not null, indexed, indexed => [name]
#  name         :string           not null, indexed => [owner_id]
#  role         :string           default("employee"), not null
#  logo         :string
#  website      :string           not null
#  location     :string           not null
#  markets      :string           not null
#  size         :string           default("1-10"), not null
#  pitch        :string           not null
#  preface      :text
#  product_info :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
