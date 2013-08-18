require 'sinatra'

if ARGV.size > 0
  config_file = ARGV[0]
else
  config_file = './env.rb'
end

require config_file

require_relative 'src/book_controller'
require_relative 'src/mapper'

get '/' do
	'Service is up'
end

get '/books' do
  content_type "application/json"
  @mapper = Mapper.new
  @book_controller = BookController.new
  @book_controller.inject_mapper @mapper
  "{\"books\": #{@book_controller.get_all_books}}"
end

post '/books' do
  content_type "application/json"
  @mapper = Mapper.new
  @book_controller = BookController.new
  @book_controller.inject_mapper @mapper
  json_format = "{\"title\":\"#{request['title']}\",\"owner\":\"#{request['owner']}\"}"
  @book_controller.save_book_from_json json_format
	'{"status":"ok"}'
end
