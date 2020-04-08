require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/gym_course.rb' )
require_relative( '../models/member.rb' )
require_relative( '../models/joining.rb' )
also_reload( '../models/*' )

get '/gym_courses' do
  @gym_courses = GymCourse.all()
  erb(:"gym_courses/index")
end

get '/gym_courses/new' do
  erb(:"gym_courses/new")
end

post '/gym_courses' do
  new_course = GymCourse.new(params)
  new_course.save()
  redirect to "/gym_courses"
end


get '/gym_courses/:id' do
  @gym_course = GymCourse.find(params[:id].to_i)
  erb(:"gym_courses/show")
end

get '/gym_courses/:id/edit' do
  @gym_course = GymCourse.find(params['id'].to_i)
  erb(:"gym_courses/edit")
end

get '/gym_courses/:id/show_partecipants' do
  @show_all = Joining.member_per_course(params['id'])
  erb(:"/gym_courses/show_partecipants")
end

post '/gym_courses/:id' do
  updated_course = GymCourse.new(params)
  updated_course.update()
  redirect to "/gym_courses"
end
