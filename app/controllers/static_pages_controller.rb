class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		# Grab a random main dish that has a picture
  		@main_dish = current_user.foods.joins(:photo).where("category = ? 
  			  AND photo_image IS NOT NULL", "Main").limit(1).order("RANDOM()")
  		@main_dish_photo = @main_dish.first.photo unless @main_dish.blank?

  		# Grab a random side dish that has a picture
  		@side_dish = current_user.foods.joins(:photo).where("category = ? 
  				AND photo_image IS NOT NULL", "Side").limit(1).order("RANDOM()")
  		@side_dish_photo = @side_dish.first.photo unless @side_dish.first.blank?

  		# Grab a random snack that has a picture
  		@snack = current_user.foods.joins(:photo).where("category = ? 
  				AND photo_image IS NOT NULL", "Snack").limit(1).order("RANDOM()")
  		@snack_photo = @snack.first.photo unless @snack.first.blank?
  	end
  end

  def demo

  end
end
