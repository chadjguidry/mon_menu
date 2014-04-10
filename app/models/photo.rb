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

  def create_homepage_thumbnail(food_category)
    case food_category
    when "Main"
      text = "Main Dishes"
    when "Side"
      text = "Side Dishes"
    when "Snack"
      text = "Snacks"
    end

    image = Image.from_blob(self.photo_image).first
    thumbnail = image.resize_to_fill(320,240, gravity=CenterGravity)
    canvas = Image.new(320, 80)
    images = ImageList.new
    txt = Draw.new
    txt.font_family = 'Helvetica'
    txt.pointsize = 32
    txt.kerning=0.75
    txt.font_weight=100
    txt.font_stretch=ExpandedStretch
    txt.stroke_width=0.05
    txt.fill = "#333333"
    txt.stroke = "#333333"
    txt.gravity = CenterGravity
    txt.annotate(canvas, 0,0,0,0, text)
    images << thumbnail
    images << canvas
    thumbnail = images.append(true)
    thumbnail.to_blob
  end

  def create_thumbnail(food_name)
    image = Image.from_blob(self.photo_image).first
    thumbnail = image.resize_to_fill(320,240, gravity=CenterGravity)
    canvas = Image.new(320, 80)
    images = ImageList.new
    txt = Draw.new
    txt.font_family = 'Helvetica'
    txt.pointsize = 24
    txt.kerning=0.75
    txt.font_weight=100
    txt.font_stretch=ExpandedStretch
    txt.stroke_width=0.05
    txt.fill = "#333333"
    txt.stroke = "#333333"
    txt.gravity = CenterGravity
    txt.annotate(canvas, 0,0,0,0, food_name)
    images << thumbnail
    images << canvas
    thumbnail = images.append(true)
    thumbnail.to_blob
  end
end
