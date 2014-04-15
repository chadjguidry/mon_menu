# == Schema Information
#
# Table name: foods
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  category    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  ingredients :text
#  prep        :text
#  prep_time   :integer
#

class Food < ActiveRecord::Base
	
# Associations
	belongs_to :user
	has_one :photo, inverse_of: :food, dependent: :destroy
	accepts_nested_attributes_for :photo

# Validations
	validates :user_id, presence: true
	validates :name, presence: { message: "Name can't be blank" }, length: { maximum: 32 }
	validates :description, presence: { message: "Description can't be blank" }
	validates_inclusion_of :category, in: %w(Main Side Snack), allow_nil: false
end
