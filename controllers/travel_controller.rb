require( 'sinatra' )
require( 'sinatra/reloader' )
require( 'pry' )

# require_relative( '../models/destination' )
# require_relative( '../models/experience' )
require_relative( '../models/travel' )
# require_relative( '../models/travel' )
also_reload( '../models/*' )

get '/travels' do # index
  @travels = Travel.all()
  erb( :'travels/index' )
end

get '/travels/new' do # new
  erb( :'travels/new' )
end

get '/travels/:id' do # show
  @travel = Travel.find( params[:id] )
  erb( :'travels/show' )
end

post '/travels' do # create
  @travel = Travel.new( params )
  @travel.save()
  erb( :'travels/create' )
end

get '/travels/:id/edit' do # edit
  @travel = Travel.find( params[:id] )
  erb( :'travels/edit' )
end

post '/travels/:id' do # update
  Travel.new( params ).update
  redirect to '/travels'
end

post '/travels/:id/delete' do # delete
  travel = Travel.find( params[:id] )
  travel.delete()
  redirect to '/travels'
end
