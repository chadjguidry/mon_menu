class ContactFormsController < ApplicationController
	def new
		@email = ContactForm.new
	end

	def create
		@email = ContactForm.new(params[:contact_form])
		@email.request = request
		if @email.deliver
			flash.now[:success] = "Thank you for your message."
			@email = ContactForm.new
			render 'new'
		else
			render 'new'
		end
	end
end
