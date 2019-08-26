require( 'sinatra' )
require( 'sinatra/reloader' )
require( 'pry' )

require_relative( './models/destination' )
require_relative( './models/experience' )
require_relative( './models/travel' )
require_relative( './models/user' )
also_reload( './models/*' )
