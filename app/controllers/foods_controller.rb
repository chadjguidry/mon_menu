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
	end

	def create
		if food_photo_params[:photo_attributes].blank?
			@food = current_user.foods.build(food_params)
		else
			@food = current_user.foods.build(food_photo_params)
		end
		@photo = @food.build_photo if @food.photo.nil?
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

		if food_photo_params[:photo_attributes].blank?
			if @food.update_attributes(food_params)
				flash[:success] = "Food edited"
				redirect_to action: :show
			else
				render 'edit'
			end
		else
			if @food.update_attributes(food_photo_params)
				flash[:success] = "Food edited"
				redirect_to action: :show
			else
				render 'edit'
			end
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

  def show_food_thumb
    @food = current_user.foods.find(params[:id])
    @photo = @food.photo
    send_data @photo.create_thumbnail(@food.name), 
    					type: @photo.photo_type, disposition: "inline"
  end

  def show_homepage_thumb
  	@food = current_user.foods.find(params[:id])
    @photo = @food.photo
    send_data @photo.create_homepage_thumbnail(@food.category), type: @photo.photo_type,
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
end