require('sinatra')
require( 'sinatra/contrib/all' )if development?
require_relative('controllers/members_controller')
require_relative('controllers/gym_courses_controller')
require_relative('controllers/joinings_controller')

get '/' do
  erb( :index )
end
