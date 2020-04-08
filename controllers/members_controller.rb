require( 'sinatra' )
require( 'sinatra/contrib/all' )if development?
require_relative( '../models/member.rb' )
also_reload( '../models/*' )

get '/members' do
  @members = Member.all()
  erb(:"members/index")
end

get '/members/new' do
  erb(:"members/new")
end

get '/members/:id/edit' do
  @member = Member.find(params['id'].to_i)
  erb(:"members/edit")
end

post '/members' do
  new_member = Member.new(params)
  new_member.save()
  erb(:"members/create")
end

post '/members/:id' do
  new_member = Member.new(params)
  new_member.update()
  redirect "/members"
end
