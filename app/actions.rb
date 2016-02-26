require 'net/http'
require 'uri'

enable :sessions

helpers do

  def resteraunt_info
    uri = URI.parse("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=49.2820004,-123.10837699999999&radius=500&type=restaurant&key=AIzaSyAVfs5AUpHDWv_RSr4x7sIhaDivbc6QaX4")
    response = Net::HTTP.get_response(uri)
    resteraunt = JSON.parse(response.body)
    hello = resteraunt["results"][0..6]
    hello.each do |i|
      i.keep_if {| key, value | key == "name" || key == "rating" || key == "vicinity" || key == "opening_hours"}
    end
    # binding.pry
    session[:resteraunt_list] = hello
  end

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
  content_type :json
  { :two_seat_wait => current_hostess(2).increase_two_seat_wait }.to_json
end

get '/restaurants/decrement_two_seat_wait' do
  # current_hostess(2)
  # .decrease_two_seat_wait
  # erb :'restaurants/waitlist'
  # redirect "/restaurants/#{@hostess.restaraunt.id}/waitlist"
  content_type :json
  { :two_seat_wait => current_hostess(2).decrease_two_seat_wait }.to_json
end

get '/restaurants/reset_two_seat_wait' do
  content_type :json
  { :two_seat_wait => current_hostess(2).reset_two_seat_wait }.to_json
end

get '/restaurants/increment_four_seat_wait' do
  content_type :json
  { :four_seat_wait => current_hostess(2).increase_four_seat_wait }.to_json
end

get '/restaurants/decrement_four_seat_wait' do
  content_type :json
  { :four_seat_wait => current_hostess(2).decrease_four_seat_wait }.to_json
end

get '/restaurants/reset_four_seat_wait' do
  content_type :json
  { :four_seat_wait => current_hostess(2).reset_four_seat_wait }.to_json
end

get '/restaurants/increment_large_table_wait' do
  content_type :json
  { :large_table_wait => current_hostess(2).increase_large_table_wait }.to_json
end

get '/restaurants/decrement_large_table_wait' do
  content_type :json
  { :large_table_wait => current_hostess(2).decrease_large_table_wait }.to_json
end

get '/restaurants/reset_large_table_wait' do
  content_type :json
  { :large_table_wait => current_hostess(2).reset_large_table_wait }.to_json
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

post '/restaurants' do
  session[:lat] = params[:lat]
  session[:lon] = params[:lon]
  resteraunt_info
  redirect :'/restaurants'
end


get '/restaurants' do
  @resteraunts_list = session[:resteraunt_list]
  # binding.pry
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























