get '/' do
  # Look in app/views/index.erb
  @photos = Photo.all
  erb :index
end

get '/test' do

	erb :test
end