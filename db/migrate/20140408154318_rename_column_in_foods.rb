class RenameColumnInFoods < ActiveRecord::Migration
  def change
  	rename_column :photos, :photo, :photo_image
  end
end
