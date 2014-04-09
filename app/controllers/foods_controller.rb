class FoodsController < ApplicationController
	before_action :authenticate_user!

	def new
		@food = current_user.foods.new
		@photo = @food.build_photo
	end

	def create
		@food = current_user.foods.build(food_params)
		@photo = @food.build_photo
		if @food.save
			flash[:success] = "New Food Added"
			redirect_to root_url
		else
			render 'new'
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
		if @food.update_attributes(food_params)
			flash[:success] = "Food edited"
			redirect_to action: :show
		else
			render 'edit'
		end
	end

	def destroy
		@food = current_user.foods.find(params[:id])
		@food.destroy
		redirect_to root_url
	end

	def show
		@food = current_user.foods.find(params[:id])
		@photo = @food.photo
	end

	def show_food_photo
    @photo = current_user.foods.find(params[:id]).photo
    send_data @photo.photo_image, type: @photo.photo_type, disposition: "inline"
  end

	private 

	def food_params
		params[:food].permit(:name, :description, :category, 
						:ingredients, :prep, :prep_time, 
						photo_attributes:[:image_file])
	end
end
