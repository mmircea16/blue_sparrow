require 'sinatra'

if ARGV.size > 0
  config_file = ARGV[0]
else
  config_file = './env.rb'
end

require config_file

require_relative 'src/book_controller'
require_relative 'src/mapper'

before do
  @book_controller = BookController.new
end

get '/' do
	'Service is up'
end

post '/books' do
  book_hash = {:title => @request["title"], :owner => @request["owner"]}
  @book_controller.create_and_save book_hash
	redirect '/books.html'
end

get '/add_book.html' do
  erb :add_book
end

get '/books.html' do
  @books = @book_controller.get_all
  erb :books
end
