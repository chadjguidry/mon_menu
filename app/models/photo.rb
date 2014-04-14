# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  photo_name  :string(255)
#  photo_type  :string(255)
#  photo_image :binary
#  food_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Photo < ActiveRecord::Base
	require 'RMagick'
  include Magick

	belongs_to :food
  validates :food, presence: true
  validate :photo_image_cannot_be_too_large
  validate :photo_image_must_be_a_photo

  def photo_image_cannot_be_too_large
    if !self.photo_image.blank?
      image = File.open("temp", 'wb') {|f| f.write self.photo_image }
      if image.size > 5242880
        errors.add(:photo_image, "can't be larger 5 megabytes")
      end
    end
  end

  def photo_image_must_be_a_photo
    if !self.photo_type.blank?
      if ((self.photo_type.to_s.eql? '"image/jpeg"') || (self.photo_type.to_s.eql? '"image/png"'))
        errors.add(:photo_type, "must be JPEG or PNG image")
      end
    end
  end

	def image_file=(input_data)
    image = Image.from_blob(input_data.read).first
  	self.photo_name = input_data.original_filename
  	self.photo_type = input_data.content_type
  	self.photo_image = image.resize_to_fill(640,480, gravity=CenterGravity).to_blob
  end

  def create_homepage_thumbnail
    image = Image.from_blob(self.photo_image).first
    thumbnail = image.resize_to_fill(320,240, gravity=CenterGravity)
    thumbnail.to_blob
  end

  def create_thumbnail
    image = Image.from_blob(self.photo_image).first
    thumbnail = image.resize_to_fill(320,240, gravity=CenterGravity)
    thumbnail.to_blob
  end
end
