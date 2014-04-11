class Food < ActiveRecord::Base
	belongs_to :user
	has_one :photo, dependent: :destroy
	accepts_nested_attributes_for :photo

	validates :name, presence: true, length: { maximum: 32 }
	validates :description, presence: true
	validates_inclusion_of :category, in: %w(Main Side Snack), allow_nil: false
end
