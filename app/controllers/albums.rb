get '/new_album' do

	erb :new_album
end

post '/new_album' do

	album_name = params[:album_name]
	album_description = params[:album_description]

	@album = Album.create_new_album(album_name, album_description, current_user.id)
	
	@user = current_user

	@flash = "Your new album has been successfully created. Upload a photo now!" 

	erb :album
end

get '/users/:user_id/albums' do

	@albums = Album.where(user_id: params[:user_id])
	@user = User.find(params[:user_id])

	erb :all_albums
end

get '/album/:album_id' do

	@album = Album.find(params[:album_id])
	@user = User.find_by(id: @album.user_id)

	erb :album
end

get '/delete_album/:album_id' do
	
	album = Album.find(params[:album_id])
	album.photos.all.each do |photo|
		photo.destroy
	end
	album.delete
	album.save
	if album.save
		@flash = "The album and all it's photos has been deleted!"
	else
		@flash = "Something went wrong somewhere..."
	end
	@user = current_user
	@albums = Album.where(user_id: current_user.id)
	erb :all_albums
end

get '/album/:album_id/edit_album' do

	@album = Album.find(params[:album_id])
	erb :edit_album
end

post '/album/:album_id/edit_album' do

	@album = Album.find(params[:album_id])
	album_name = params[:album_name]
	album_description = params[:album_description]

	@album.update(name: album_name, description: album_description)
	
	@user = current_user

	@flash = "Your album has been updated successfully!" 

	erb :album
end


