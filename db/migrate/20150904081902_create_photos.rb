class CreatePhotos < ActiveRecord::Migration
  def change
  	create_table :photos do |t|
  		t.integer :user_id
  		t.integer :album_id
  		t.string :name
  		t.string :description
  		t.string :file
  		t.timestamps null: false
  	end
  end
end
