
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

  def create_resteraunts
    session[:resteraunt_list].each do |i|
      Restaraunt.create(name: i["name"], address: i["vicinity"], ratings: i["rating"])
    end
   end

  def current_hostess
    Hostess.find(session[:hostess_id]) if session[:hostess_id]
  end

  def check_flash
    @flash = session[:flash] if session[:flash]
    session[:flash] = nil
  end

end

before do
  current_hostess
  check_flash
end

#----------------------RESTAURANT VIEWS----------------------#

get '/restaurants/login' do
  @restaurants = Restaraunt.all  
  erb :'restaurants/login'
end

# NOTE: this login may be optional for demo, see demologin below
post '/restaurants/login'do
  username = params[:username]
  password = params[:password]
  hostess = Hostess.find_by username: username, password: password
  if hostess
    session[:hostess_id] = hostess.id
    redirect "/restaurants/#{hostess.restaraunt_id}/waitlist"
  else
    session[:flash] = "Invalid Login"
    redirect 'restaurants/login'
  end
end

post '/restaurants/demologin' do
  session[:hostess_id] = params[:hostess_id]
  redirect "/" #NOTE: temporary, waitlist page not created yet
end

# NOTE: this is a temporary login page with Tom's edits
get '/login' do
  erb :'login'
end

get '/logout' do
  session.clear
  redirect '/'
end

# TODO: is this following block optional???
get '/restaurants/:id/waitlist' do
  @hostess = current_hostess
  erb :'restaurants/waitlist'
end

# NOTE: below is Tom's crazy awesome engine
get '/restaurants/increment_two_seat_wait' do
  content_type :json
  { :two_seat_wait => @hostess.increase_two_seat_wait }.to_json
end

get '/restaurants/decrement_two_seat_wait' do
  content_type :json
  { :two_seat_wait => @hostess.decrease_two_seat_wait }.to_json
end

get '/restaurants/reset_two_seat_wait' do
  content_type :json
  { :two_seat_wait => @hostess.reset_two_seat_wait }.to_json
end

get '/restaurants/increment_four_seat_wait' do
  content_type :json
  { :four_seat_wait => @hostess.increase_four_seat_wait }.to_json
end

get '/restaurants/decrement_four_seat_wait' do
  content_type :json
  { :four_seat_wait => @hostess.decrease_four_seat_wait }.to_json
end

get '/restaurants/reset_four_seat_wait' do
  content_type :json
  { :four_seat_wait => @hostess.reset_four_seat_wait }.to_json
end

get '/restaurants/increment_large_table_wait' do
  content_type :json
  { :large_table_wait => @hostess.increase_large_table_wait }.to_json
end

get '/restaurants/decrement_large_table_wait' do
  content_type :json
  { :large_table_wait => @hostess.decrease_large_table_wait }.to_json
end

get '/restaurants/reset_large_table_wait' do
  content_type :json
  { :large_table_wait => @hostess.reset_large_table_wait }.to_json
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
  create_resteraunts
  redirect :'/restaurants'
end


get '/restaurants' do
  gon.resteraunts = []
  @resteraunts_list = session[:resteraunt_list]
  resteraunts = @resteraunts_list
  if resteraunts == nil

  else
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
