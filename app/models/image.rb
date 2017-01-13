class Image < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :image, presence: true
  validates_integrity_of :image
  validates_processing_of :image

  def generate_token
    self.token = SecureRandom.hex(rand(4..8))
    generate_token if self.class.exists?(token: self.token)
    self.token
  end
end

# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  token      :string(32)       not null, indexed
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
