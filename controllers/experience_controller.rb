require( 'sinatra' )
require( 'sinatra/reloader' )
require( 'pry' )

require_relative( '../models/destination' )
require_relative( '../models/experience' )
# require_relative( '../models/travel' )
# require_relative( '../models/experience' )
also_reload( '../models/*' )

get '/experiences' do # index
  @experiences = Experience.all()
  erb( :'experiences/index' )
end

get '/experiences/new' do # new
  @destinations = Destination.all()
  erb( :'experiences/new' )
end

get '/experiences/:id' do # show
  @experience = Experience.find( params[:id] )
  erb( :'experiences/show' )
end

post '/experiences' do # create
  @experience = Experience.new( params )
  @experience.save()
  erb( :'experiences/create' )
end

get '/experiences/:id/edit' do # edit
  @experience = Experience.find( params[:id] )
  @destinations = Destination.all()
  erb( :'experiences/edit' )
end

post '/experiences/:id' do # update
  Experience.new( params ).update
  redirect to '/experiences'
end

post '/experiences/:id/delete' do # delete
  experience = Experience.find( params[:id] )
  experience.delete()
  redirect to '/experiences'
end
