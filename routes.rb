require 'sinatra'

get '/welcome' do
	send_file File.join("/","welcome.html")
end

get '/README' do
	send_file File.join("/","README")
end
