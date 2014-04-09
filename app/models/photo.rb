class Photo < ActiveRecord::Base
	require 'RMagick'
  include Magick

	belongs_to :food

	def image_file=(input_data)
    image = Image.from_blob(input_data.read).first
  	self.photo_name = input_data.original_filename
  	self.photo_type = input_data.content_type
  	self.photo_image = image.resize_to_fill(640,480, gravity=CenterGravity).to_blob
  end
end
