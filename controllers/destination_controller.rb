require( 'sinatra' )
require( 'sinatra/reloader' )
require( 'pry' )

require_relative( '../models/destination' )
# require_relative( '../models/experience' )
# require_relative( '../models/travel' )
# require_relative( '../models/destination' )
also_reload( '../models/*' )

get '/destinations' do # index
  @destinations = Destination.all()
  erb( :'destinations/index' )
end

get '/destinations/new' do # new
  erb( :'destinations/new' )
end

get '/destinations/search/:string' do # index
  @destinations = Destination.fuzzy_search(params['string'])
  erb( :'destinations/index' )
end

get '/destinations/:id' do # show
  @destination = Destination.find( params[:id] )
  erb( :'destinations/show' )
end

post '/destinations/index' do
  destination = params['destination']
  if destination == ""
    redirect to "/destinations"
  else
    redirect to "/destinations/search/#{destination}"
  end
end

post '/destinations' do # create
  @destination = Destination.new( params )
  @destination.save()
  erb( :'destinations/create' )
end

get '/destinations/:id/edit' do # edit
  @destination = Destination.find( params[:id] )
  erb( :'destinations/edit' )
end

post '/destinations/:id' do # update
  Destination.new( params ).update
  redirect to '/destinations'
end

post '/destinations/:id/delete' do # delete
  destination = Destination.find( params[:id] )
  destination.delete()
  redirect to '/destinations'
end
