class Album < ActiveRecord::Base
  # Remember to create a migration!

  belongs_to :user
  has_many :photos

  def self.create_new_album(album_name, album_description, user_id)
		Album.create(name: album_name, description: album_description, user_id: user_id)
	end
end
