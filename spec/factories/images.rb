# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  token      :string(32)       not null, indexed
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :image do
    token { SecureRandom.hex(10) }
    file { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/support/images/image.jpg'))) }
  end
end
