require 'sinatra'

get '/' do
	'Service is up'
end

get '/welcome.html' do
	#"Hello world"
	send_file File.join(File.dirname(__FILE__),"welcome.html")
end

get '/README' do
	content_type "text/plain"
	send_file File.join(File.dirname(__FILE__),"README")
end

get '/books' do
	'{"books":[{"book":"Agile Testing"}]}'
	
end

post '/books' do
	'{"status":"ok"}'
end
