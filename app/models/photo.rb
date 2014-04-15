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

# Constant for max image size
MAX_IMAGE_SIZE = 5242880

# Using RMagick for image manipulation
  require 'RMagick'
  include Magick

# Associations
	belongs_to :food

# Validations 
  validates :food, presence: true
  validate :photo_image_cannot_be_too_large
  validate :photo_image_must_be_a_photo

# Custom validation method
  def photo_image_cannot_be_too_large
    if !self.photo_image.blank?
      image = File.open("temp", 'wb') {|f| f.write self.photo_image }
      if image.size > MAX_IMAGE_SIZE
        errors.add(:photo_image, "Photo can't be larger than 5 megabytes")
      end
    end
  end

# Custom validation method
  def photo_image_must_be_a_photo
    if !self.photo_type.blank?
      if !((self.photo_type.to_s.eql? 'image/jpeg') || \
           (self.photo_type.to_s.eql? 'image/png'))
        self.errors.add(:photo_type, "Photo must be JPEG or PNG image")
      end
    end
  end

# Method to grab and process image upload
	def image_file=(input_data)
# If the image type is valid, process the image for saving
# to the database
    if ((input_data.content_type.eql? 'image/jpeg') || \
        (input_data.content_type.eql? 'image/png'))
      image = Image.from_blob(input_data.read).first
    	self.photo_name = input_data.original_filename
    	self.photo_type = input_data.content_type
    	self.photo_image = image.resize_to_fill(640,480, 
                          gravity=CenterGravity).to_blob
    else
# If the image type is not valid, set the photo_type to invalid
# and let the custom validation method handle the problem
      self.photo_type = "invalid"
    end
  end

# Method to generate thumbnails for users' home page
  def create_homepage_thumbnail
    image = Image.from_blob(self.photo_image).first
    thumbnail = image.resize_to_fill(320,240, gravity=CenterGravity)
    thumbnail.to_blob
  end

# Method to generate thumbnail for categorical menus
  def create_thumbnail
    image = Image.from_blob(self.photo_image).first
    thumbnail = image.resize_to_fill(320,240, gravity=CenterGravity)
    thumbnail.to_blob
  end
end