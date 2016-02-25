# Homepage (Root path)
get '/' do
  erb :index
end

post '/go' do
  @lat = params[:lat]
  @lon = params[:lon]
  erb :index
end