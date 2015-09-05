get '/albums/:album_id/new_photo' do

	@album = Album.find(params[:album_id])
	@albums = Album.where(user_id: current_user.id)

	erb :new_photo
end

get '/albums/new_photo' do

	if logged_in?
		@albums = Album.where(user_id: current_user.id)
		@name = ""
		@description = ""
		erb :new_photo
	else
		@flash = "Please log in or sign up to post a photo!"
		erb :logged_in
	end

end

post '/albums/new_photo' do
	
	@album = Album.find(params[:album_id])
	@name = params[:photo_name]
	@description = params[:photo_description]
	file = params[:image]

	new_photo = Photo.new(name: @name, description: @description, user_id: current_user.id, file: file, album_id: @album.id)
	
	new_photo.save
	if new_photo.save
		@flash = "Image uploaded successfully!"
		@user = current_user
		erb :album
	else
		@flash = "You must select an image to upload!"
		@albums = Album.where(user_id: current_user.id)
		erb :new_photo
	end
end

get '/albums/:album_id/:photo_id' do
	@photo = Photo.find(params[:photo_id])
	@user = current_user
	erb :photo
end

get '/delete_photo/:photo_id' do
	
	photo = Photo.find(params[:photo_id])
	@album = Album.find(photo.album_id)
	photo.delete
	photo.save
	if photo.save
		@flash = "The photo has been deleted!"
	else
		@flash = "Something went wrong somewhere..."
	end
	@user = current_user
	erb :album
end