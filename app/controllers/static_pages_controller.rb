class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		# Grab a random main dish that has a picture
  		@main_dish = current_user.foods.joins(:photo).where("category = ? 
  			  AND photo_image IS NOT NULL", "Main").limit(1).order("RANDOM()")
      if @main_dish.blank?
        @main_dish = current_user.foods.where("category = ?", 'Main')
      end

  		# Grab a random side dish that has a picture
  		@side_dish = current_user.foods.joins(:photo).where("category = ? 
  				AND photo_image IS NOT NULL", "Side").limit(1).order("RANDOM()")
      if @side_dish.blank?
        @side_dish = current_user.foods.where("category = ?", 'Side')
      end

  		# Grab a random snack that has a picture
  		@snack = current_user.foods.joins(:photo).where("category = ? 
  				AND photo_image IS NOT NULL", "Snack").limit(1).order("RANDOM()")
      if @snack.blank?
        @snack = current_user.foods.where("category = ?", 'Snack')
      end
    else
      render layout: 'visitor_home'
  	end
  end

  def demo
  end

  def about
  end

  def privacy
  end

  def terms_of_service
  end

end
