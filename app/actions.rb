helpers do

  def current_hostess(id)
    Hostess.find(id)
  end

end

before do


end

# Homepage (Root path)

#----------------------RESTAURANT VIEWS----------------------#

post '/restaurants/login'do
# TODO: implement login
end

get '/restaurants/logout' do
  session.clear
  redirect '/restaurants'
end

# TODO: is this following block optional???
get '/restaurants/:id/waitlist' do
  @hostess = current_hostess(2)
  erb :'restaurants/waitlist'
end

get '/restaurants/increment_two_seat_wait' do
  @hostess = current_hostess(2)
  @hostess.increase_two_seat_wait
  erb :'restaurants/waitlist'
end

get '/restaurants/decrement_two_seat_wait' do
  @hostess = current_hostess(2)
  @hostess.decrease_two_seat_wait
  erb :'restaurants/waitlist'
end

get '/restaurants/reset_two_seat_wait' do
  @hostess = current_hostess(2)
  @hostess.reset_two_seat_wait
  erb :'restaurants/waitlist'
end

get '/restaurants/increment_four_seat_wait' do
  @hostess = current_hostess(2)
  @hostess.increase_four_seat_wait
  erb :'restaurants/waitlist'
end

get '/restaurants/decrement_four_seat_wait' do
  @hostess = current_hostess(2)
  @hostess.decrease_four_seat_wait
  erb :'restaurants/waitlist'
end

get '/restaurants/reset_four_seat_wait' do
  @hostess = current_hostess(2)
  @hostess.reset_four_seat_wait
  erb :'restaurants/waitlist'
end

get '/restaurants/increment_large_table_wait' do
  @hostess = current_hostess(2)
  @hostess.increase_large_table_wait
  erb :'restaurants/waitlist'
end

get '/restaurants/decrement_large_table_wait' do
  @hostess = current_hostess(2)
  @hostess.decrease_large_table_wait
  erb :'restaurants/waitlist'
end

get '/restaurants/reset_large_table_wait' do
  @hostess = current_hostess(2)
  @hostess.reset_large_table_wait
  erb :'restaurants/waitlist'
end
#----------------------USER VIEWS----------------------#

# NOTE: redirects to the restaurant's waitlist if logged in
# else goes to the customer's view of all restaurants
get '/' do
  if session[:restaurant_id]
    redirect '/restaurants/waitlist'
  else
    redirect '/restaurants'
  end
end

get '/restaurants' do
  erb :'restaurants/index'
end

get '/restaurants/:id' do
  erb :'restaurants/show'
end

#----------------------DEBUGGING VIEWS----------------------#

# the views here are for debugging, not included in public nav

get '/debug' do
  erb :debug
end
















#
