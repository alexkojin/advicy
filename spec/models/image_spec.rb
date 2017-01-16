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

require 'rails_helper'

RSpec.describe Image, type: :model do
  it 'valid with an image file' do
    image = build(:image)
    image.valid?
    expect(image).to be_valid
  end

  it 'is invalid without an image file' do
    image = build(:image, file: nil)
    image.valid?
    expect(image.errors[:file]).to include("can't be blank")
  end

  it 'is invalid with wrong image content type' do
    image = build(:image, file: File.open(File.join(Rails.root, 'spec/support/images/web-page.html')))
    image.valid?
    expect(image.errors[:file]).to include('You are not allowed to upload "html" files, allowed types: jpg, jpeg, gif, png')
  end

  it 'is invalid with an image size greater 2mb' do
    image = build(:image, file: File.open(File.join(Rails.root, 'spec/support/images/image-3mb.jpg')))
    image.valid?
    expect(image.errors[:file]).to include("File size should be less than 2097152")
  end

  it 'generates unique token before save' do
    image = create(:image, token: nil)
    expect(image.token).not_to be_empty
  end

  it 'save a file to storage' do
    image = create(:image)
    expect(File.exists?(image.file.path)).to be true
  end
end
