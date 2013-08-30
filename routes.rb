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


DataMapper.auto_upgrade!

set :sinatra_authentication_view_path, Pathname(__FILE__).dirname.expand_path + "views/"
set :template_engine, :haml

before do
  @book_controller = BookController.new
  @menu_classes = { :home => [], :about_us => [], :contact => []}
end


get '/' do
  @menu_classes['home'] = ['active']
  haml :home_page
end

get '/about_us' do
  @menu_classes['about_us'] = ['active']
  haml :about_us
end

get '/contact' do
  @menu_classes['contact'] = ['active']
  haml :contact
end


post '/books'do
  login_required
  book_hash = {:title => @request["title"], :owner => current_user.email}
  @book_controller.create_and_save book_hash
	redirect '/books.html'
end

get '/add_book.html'do
  login_required
  haml :add_book
end

get '/books.html' do
  @books = @book_controller.get_all
  haml :books
end
