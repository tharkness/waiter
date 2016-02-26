
enable :sessions

helpers do

  def resteraunt_info
    uri = URI.parse("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{session[:lat]},#{session[:lon]}&radius=200&type=restaurant&key=AIzaSyAVfs5AUpHDWv_RSr4x7sIhaDivbc6QaX4")
    response = Net::HTTP.get_response(uri)
    resteraunt = JSON.parse(response.body)
    hello = resteraunt["results"][0..8]
    hello.each do |i|
      i.keep_if {| key, value | key == "name" || key == "rating" || key == "vicinity" || key == "opening_hours" || key == "geometry"}
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

post '/restaurants' do
  session[:lat] = BigDecimal.new(params[:lat])
  session[:lon] = BigDecimal.new(params[:lon])
  resteraunt_info
  redirect :'/restaurants'
end


get '/restaurants' do
  gon.resteraunts = []
  @resteraunts_list = session[:resteraunt_list]
  resteraunts = @resteraunts_list
  resteraunts.each do |i|
    i.each do |key, value|
      if key == "geometry" || key == "name"
       gon.resteraunts << value if key == "name" 
        if value.is_a? Hash
          value.each do |key, value|
            if key == "location"
              gon.resteraunts << value
            end
          end
        end
      end
    end
  end
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























