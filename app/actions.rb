
enable :sessions

helpers do

  def resteraunt_info
    uri = URI.parse("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{session[:lat]},#{session[:lon]}&radius=200&type=restaurant&key=AIzaSyAVfs5AUpHDWv_RSr4x7sIhaDivbc6QaX4")
    response = Net::HTTP.get_response(uri)
    resteraunt = JSON.parse(response.body)
    hello = resteraunt["results"][0..8]
    hello.each do |i|
      i.keep_if {| key, value | key == "name" || key == "rating" || key == "vicinity" || key == "opening_hours" || key == "geometry" || key == "place_id" || key == "geometry"}
    end

    goodbye = hello
    gon.resteraunts = []
    goodbye.each do |i|
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
      hello.each do |i|
        Restaraunt.create(name: i["name"], address: i["vicinity"], ratings: i["rating"], google_id: i["place_id"], lat: i["geometry"]["location"]["lat"], lon: i["geometry"]["location"]["lng"])
      end
    end
    # binding.pry
  end

  def current_hostess
    Hostess.find(session[:hostess_id]) if session[:hostess_id]
  end

  def check_flash
    @flash = session[:flash] if session[:flash]
    session[:flash] = nil
  end

  def return_eight(array)
    result = []
    array.each_with_index do |item, index|
      result << item if index <= 7
    end
    result
  end

# BEGIN helper methods for the index page
  def restaurant_in_db?(restaurant)
    restaurant.hostesses[0]
  end

  def party_size_wait(restaurant)
    case session[:party_size].to_i
    when 2
      restaurant.two_seat_wait
    when 4
      restaurant.four_seat_wait
    when 5
      restaurant.large_table_wait
    end
  end

  def homepage_wait_tag(restaurant)
    wait_time = party_size_wait(restaurant)
    if restaurant_in_db?(restaurant)
      if wait_time < 10
        "<p class='tag is-success is-pulled-right'>#{wait_time} min</p>"
      elsif wait_time > 20
        "<p class='tag is-danger is-pulled-right'>#{wait_time} min</p>"
      else
        "<p class='tag is-warning is-pulled-right'>#{wait_time} min</p>"
      end
    else
      "<p class='tag is-pulled-right'>n/a</p>"
    end
  end
# END helper methods for the index page

# BEGIN search page tags, definitely needs refactor
  def wait_tag(restaurant, party)
    wait = 0
    case party
    when 2
      wait = restaurant.two_seat_wait
    when 4
      wait = restaurant.four_seat_wait
    when 5
      wait = restaurant.large_table_wait
    end

    if restaurant_in_db?(restaurant)
      if wait < 10
        "<p class='tag is-success'>#{wait} min</p>"
      elsif wait > 20
        "<p class='tag is-danger'>#{wait} min</p>"
      else
        "<p class='tag is-warning'>#{wait} min</p>"
      end
    else
      "<p class='tag'>n/a</p>"
    end
  end
# END search page tags

end

before do
  current_hostess
  check_flash
end

#----------------------RESTAURANT VIEWS----------------------#

get '/restaurants/login' do
  Restaraunt.all ? (@restaurants = Restaraunt.all) : (@restaurants = [])
  erb :'restaurants/login'
end

post '/restaurants/demologin' do
  session[:hostess_id] = params[:hostess_id]
  redirect "/restaurants/waitlist"
end

get '/logout' do
  session[:hostess_id] = nil
  redirect '/'
end

get '/restaurants/waitlist' do
  # binding.pry
  @hostess = Hostess.find(session[:hostess_id]) if session[:hostess_id]
  erb :'restaurants/waitlist'
end

# NOTE: below is Tom's crazy awesome engine
get '/restaurants/increment_two_seat_wait' do
  content_type :json
  { :two_seat_wait => current_hostess.increase_two_seat_wait }.to_json
end

get '/restaurants/decrement_two_seat_wait' do
  content_type :json
  { :two_seat_wait => current_hostess.decrease_two_seat_wait }.to_json
end

get '/restaurants/reset_two_seat_wait' do
  content_type :json
  { :two_seat_wait => current_hostess.reset_two_seat_wait }.to_json
end

get '/restaurants/increment_four_seat_wait' do
  content_type :json
  { :four_seat_wait => current_hostess.increase_four_seat_wait }.to_json
end

get '/restaurants/decrement_four_seat_wait' do
  content_type :json
  { :four_seat_wait => current_hostess.decrease_four_seat_wait }.to_json
end

get '/restaurants/reset_four_seat_wait' do
  content_type :json
  { :four_seat_wait => current_hostess.reset_four_seat_wait }.to_json
end

get '/restaurants/increment_large_table_wait' do
  content_type :json
  { :large_table_wait => current_hostess.increase_large_table_wait }.to_json
end

get '/restaurants/decrement_large_table_wait' do
  content_type :json
  { :large_table_wait => current_hostess.decrease_large_table_wait }.to_json
end

get '/restaurants/reset_large_table_wait' do
  content_type :json
  { :large_table_wait => current_hostess.reset_large_table_wait }.to_json
end

get '/restaurants/set_four_seat_wait' do
  content_type :json
  { :four_seat_wait => current_hostess.set_four_seat_wait(params[:four_seat_time]) }.to_json
  redirect :'/restaurants/waitlist'
end

get '/restaurants/set_two_seat_wait' do
  content_type :json
  { :two_seat_wait => current_hostess.set_two_seat_wait(params[:two_seat_time]) }.to_json
  redirect :'/restaurants/waitlist'
end

get '/restaurants/set_large_table_wait' do
  content_type :json
  { :large_table_wait => current_hostess.set_large_table_wait(params[:large_table_time]) }.to_json
  redirect :'/restaurants/waitlist'
end
#----------------------USER VIEWS----------------------#

# NOTE: redirects to the restaurant's waitlist if logged in
# else goes to the customer's view of all restaurants
get '/' do

  if session[:hostess_id]
    redirect '/restaurants/waitlist'
  else
    erb :index
  end
end

post '/restaurants' do
  session[:lat] = BigDecimal.new(params[:lat])
  session[:lon] = BigDecimal.new(params[:lon])
  session[:party_size] = params[:party_size] if params[:party_size]
  resteraunt_info
  redirect :'/restaurants'
end

post '/' do
  session[:lat] = BigDecimal.new(params[:lat])
  session[:lon] = BigDecimal.new(params[:lon])
  session[:party_size] = params[:party_size] if params[:party_size]
  resteraunt_info
  redirect :'/restaurants'
end

get '/restaurants' do
  @resteraunts_list = resteraunt_info
  @restaurants = return_eight(Restaraunt.all)
  erb :'restaurants/index'
end

get '/restaurants/:id' do
  erb :'restaurants/show'
end

get '/search' do
  @results = Restaraunt.all
  if params[:term]
    @results = Restaraunt.search(params[:term])
  else
    @results = Restaraunt.all
  end
  erb :'restaurants/show'
end


#----------------------DEBUGGING VIEWS----------------------#

# the views here are for debugging, not included in public nav

get '/debug' do
  erb :debug
end
