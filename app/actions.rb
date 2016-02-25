helpers do



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
