class AddColumnsToFoods < ActiveRecord::Migration
  def change
  	add_column :foods, :ingredients, :text
  	add_column :foods, :prep, :text
  	add_column :foods, :prep_time, :integer
  end
end
