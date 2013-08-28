require 'sinatra'
require "dm-core"
#for using auto_migrate!
require "dm-migrations"
require "digest/sha1"
require "sinatra-authentication"

use Rack::Session::Cookie, :secret => 'a very secret key'

if ARGV.size > 0
  config_file = ARGV[0]
else
  config_file = './env.rb'
end

require config_file

require_relative 'src/book_controller'
require_relative 'src/mapper'

DataMapper.auto_migrate!

before do
  @book_controller = BookController.new
end


get '/' do
  send(:erb,"<h1>fasf</h1>",:layout => false)

end


post '/books' do
  book_hash = {:title => @request["title"], :owner => @request["owner"]}
  @book_controller.create_and_save book_hash
	redirect '/books.html'
end

get '/add_book.html' do
  haml :add_book
end

get '/books.html' do
  @books = @book_controller.get_all
  haml :books
end
