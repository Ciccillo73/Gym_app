require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/joining.rb' )
require_relative( '../models/member.rb' )
require_relative( '../models/gym_course.rb' )
also_reload( '../models/*' )

get '/joinings' do
  @bookings = Joining.all()
  erb(:"/joinings/show")
end



get '/joinings/new' do
  @courses = GymCourse.all()
  @members = Member.all()
  erb(:"/joinings/new")
end

post '/joinings' do
  new_book = Joining.new(params)
  new_book.save()
  redirect to "joinings"
end

post '/joinings/:id/delete' do
  Joining.destroy(params['id'])
  redirect to "/joinings"
end
