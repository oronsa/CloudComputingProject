require 'sinatra'
require './database'
require './register'
require './user'
require './utilities'

HINTS_HASH_MAP = Hash.new
USERS_HASH_MAP = Hash.new

set :port, 8080
set :views, 'views'
set :bind, '0.0.0.0'

#load main page with users and hintIDs from db
get '/' do
  set_students_hash_map
	set_hints_hash_map
	erb :menu
end

get '/login' do
	erb :login
end
get '/register' do
	erb :register
end

get '/recover' do
	erb :recover
end
get '/remove' do
	erb :remove
end

get '/showAll' do
	show_all
end

get '/quit' do
	Process.kill 'TERM', Process.pid
end


post '/login' do
	#get info from ERB form
	email = params[:email]
	passwd = params[:password]
	log_in_user(email,passwd)
end

post '/register' do
	#get info from ERB form
	name = params[:name]
	passwd = params[:passwd]
	email = params[:email]
	register_user(name, passwd, email)
end

post '/recover' do
	#get info from ERB form
	email = params[:email]
	new_pass = params[:new_pass]
	recover_pass(email,new_pass)
end

post '/remove' do
	#get info from ERB form
	email = params[:email]
	passwd = params[:password]
	remove_user(email,passwd)
end


post '/hints' do
	hintAnswer = params[:hintAnswer]
	hintID = params[:hintID]
	update_user_hints(hintID, hintAnswer)
	##insert the new user into the db
	save_user
	erb :message, :locals => { :message => 'registration complete!' }
end
