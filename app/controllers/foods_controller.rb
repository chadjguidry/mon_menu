class FoodsController < ApplicationController
	before_action :authenticate_user!

	def index
		@foods = current_user.foods.load.order('name')
	end

	def main_dishes
		@foods = current_user.foods.where("category = ?", "Main").order('name')
	end

	def side_dishes
		@foods = current_user.foods.where("category = ?", "Side").order('name')
	end

	def snacks
		@foods = current_user.foods.where("category = ?", "Snack").order('name')
	end

	def new
		@food = current_user.foods.new
		@photo = @food.build_photo

		# for the users_home add food links if no 
		# foods exists in the specified category 
		case params[:food_category]
		when 'Main'
			@food.category = 'Main'
		when 'Side'
			@food.category = 'Side'
		when 'Snack'
			@food.category = 'Snack'
		end
	end

	def create
		# file = food_photo_params[:photo_attributes][:image_file].read
		# render text: file.size
		if food_photo_params[:photo_attributes].blank?
			@food = current_user.foods.build(food_params)
			@photo = @food.build_photo
			if @food.save
				redirect_to food_path(@food)
			else
				render 'new'
			end
		else
			image = food_photo_params[:photo_attributes][:image_file]
			@food = current_user.foods.build(food_photo_params)
			if ((image.content_type.eql? 'image/jpeg') || (image.content_type.eql? 'image/png')) && (image.size < 4000000)
				if @food.save
					redirect_to food_path(@food)
				else
					render 'new'
				end
			else
				@photo = @food.build_photo
				flash.now[:danger] = "Photo must be a JPEG or PNG under 5 megabytes"
				render 'new'
			end
		end		
	end

	def edit
		@food = current_user.foods.find(params[:id])
		@photo = @food.photo
	end

	def update
		@food = current_user.foods.find(params[:id])
		@photo = @food.photo
		if params[:remove_photo] 
      @photo.photo_image = nil
      @photo.photo_type = ""
      @photo.photo_name = ""
    end

		if food_photo_params[:photo_attributes].blank?
			if @food.update_attributes(food_params)
				redirect_to action: :show
			else
				render 'edit'
			end
		else
			image = food_photo_params[:photo_attributes][:image_file]
			if ((image.content_type.eql? 'image/jpeg') || (image.content_type.eql? 'image/png')) && (image.size < 4000000)
				if @food.update_attributes(food_photo_params)
					redirect_to action: :show
				else
					render 'edit'
				end
			else
				flash.now[:danger] = "Photo must be a JPEG or PNG under 5 megabytes"
				render 'edit'
			end
		end
	end

	def destroy
		@food = current_user.foods.find(params[:id])
		@return_path = category_return_path(@food.category)
		@food.destroy
		redirect_to @return_path
	end

	def show
		@food = current_user.foods.find(params[:id])
		@photo = @food.photo
		@return_path = category_return_path(@food.category)
	end

	def show_food_photo
    @photo = current_user.foods.find(params[:id]).photo
    send_data @photo.photo_image, type: @photo.photo_type, disposition: "inline"
  end

  def show_food_thumb
    @food = current_user.foods.find(params[:id])
    @photo = @food.photo
    send_data @photo.create_thumbnail, 
    					type: @photo.photo_type, disposition: "inline"
  end

  def show_homepage_thumb
  	@food = current_user.foods.find(params[:id])
    @photo = @food.photo
    send_data @photo.create_homepage_thumbnail, type: @photo.photo_type,
              disposition: "inline"
  end

	private 

	def food_params
		params[:food].permit(:name, :description, :category, 
						:ingredients, :prep, :prep_time)
	end

	def food_photo_params
		params[:food].permit(:name, :description, :category, 
						:ingredients, :prep, :prep_time, 
						photo_attributes:[:image_file])
	end

	def category_return_path(food_category)
		case food_category
		when 'Main'
			foods_main_dishes_path
		when 'Side'
			foods_side_dishes_path
		when 'Snack'
			foods_snacks_path
		end
	end
end