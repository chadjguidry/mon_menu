class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo_name
      t.string :photo_type
      t.binary :photo
      t.integer :food_id

      t.timestamps
    end
  end
end
