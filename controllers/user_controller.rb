require( 'sinatra' )
require( 'sinatra/reloader' )
require( 'pry' )

# require_relative( '../models/destination' )
# require_relative( '../models/experience' )
# require_relative( '../models/travel' )
require_relative( '../models/user' )
also_reload( '../models/*' )

get '/users' do # index
  @users = User.all()
  erb( :'users/index' )
end

get '/users/new' do # new
  erb( :'users/new' )
end

get '/users/:id' do # show
  @user = User.find( params[:id] )
  erb( :'users/show' )
end

post '/users' do # create
  @user = User.new( params )
  @user.save()
  erb( :'users/create' )
end

get '/users/:id/edit' do # edit
  @user = User.find( params[:id] )
  erb( :'users/id/edit' )
end

post '/users/:id' do # update
  User.new( params ).update
  redirect to '/users'
end

post '/users/:id/delete' do # delete
  user = User.find( params[:id] )
  user.delete()
  redirect to '/users'
end
