require 'net/http'
require 'uri'

# Homepage (Root path)
get '/' do
  erb :index
end

post '/go' do
  @lat = params[:lat]
  @lon = params[:lon]
  uri = URI.parse("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=49.2820004,-123.10837699999999&radius=500&type=restaurant&key=AIzaSyAVfs5AUpHDWv_RSr4x7sIhaDivbc6QaX4")
  response = Net::HTTP.get_response(uri)
  resteraunt = JSON.parse(response.body)
  @restaurant_list = resteraunt["results"]
  @restaurant_list.each do |i|
    i.keep_if {| key, value | key == "name" || key == "rating" || key == "vicinity" || key == "opening_hours"}
  end
  erb :index
end

get '/go/nearby' do
  redirect "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&type=restaurant&name=cruise&key=AIzaSyAVfs5AUpHDWv_RSr4x7sIhaDivbc6QaX4"
end



