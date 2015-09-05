get '/login' do

	@login_name = ""
	@signup_name = ""
	@email = ""

	erb :login
end

post '/login' do

	@login_name = params[:name]
	@password = params[:password]

	if User.authenticate(@login_name, @password)
		session[:user_id] = User.find_by(name: @login_name).id
		@user = current_user
		@flash = "Welcome back #{@user.name}!"
		@photos = Photo.all
		erb :index
	else
		@flash = "Invalid username or password!"
		erb :login
	end
end

post '/signup' do

	@signup_name = params[:name]
	@email = params[:email]
	@password = params[:password]
	@new_user = User.new(name: @signup_name, email: @email, password: @password)
	
	@new_user.save
	if @new_user.save
		Album.create_new_album("Default album", "Album description", @new_user.id)
		@flash = "Account successfully created! You may log in now."
		@signup_name = ""
		@email = ""
	else
		@flash = @new_user.errors.messages.first #=~ " /(\[\:)(\w{1,})(\,\s\[\")((\w{1,}\s){1,}(\w{1,}))(\"\]\])/, '/2', '/4' "
	end
	erb :login
end

get '/logout' do

	session[:user_id] = nil
	@flash = "You have successfulley logged out."
	@photos = Photo.all
	erb :index
end

get '/users/:user_id' do

	@user = User.find(params[:user_id])

	erb :users
end

get '/users/:user_id/edit_profile' do
	@user = current_user

	erb :edit_profile
end

post '/users/:user_id/edit_profile' do
	name = params[:name]
	email = params[:email]
	password = params[:password]
	about = params[:about]
	current_user.update(name: name, email: email, password: password, about: about)
	
	@flash = "Your profile has been updated successfully!"
	@user = current_user
	erb :users
end

