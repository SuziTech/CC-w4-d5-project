require( 'sinatra' )
require( 'sinatra/reloader' )
require( 'pry' )

require_relative( './controllers/destination_controller' )
require_relative( './controllers/experience_controller' )
# require_relative( './controllers/travel_controller' )
# require_relative( './controllers/user_controller' )
also_reload( './models/*' )
