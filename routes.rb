require 'sinatra'

get '/' do
	'Service is up'
end

get '/welcome.html' do
	#"Hello world"
	send_file "welcome.html"
end

get '/README' do
	content_type "text/plain"
	send_file "README"
end
