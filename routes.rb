require 'sinatra'
require_relative 'book_controller'
require_relative 'mapper'




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
  @mapper = Mapper.new
  @book_controller = BookController.new
  @book_controller.inject_mapper @mapper
  "{\"books\": #{@book_controller.get_all_books}}"
end

post '/books' do
  @mapper = Mapper.new
  @book_controller = BookController.new
  @book_controller.inject_mapper @mapper
  json_format = "{\"title\":\"#{request['title']}\",\"owner\":\"#{request['owner']}\"}"
  @book_controller.save_book_from_json json_format
	'{"status":"ok"}'
end
