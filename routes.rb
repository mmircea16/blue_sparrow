require 'sinatra'
require "dm-core"
#for using auto_migrate!
require "dm-migrations"
require './src/monkey_patches/data_mapper_patch'
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
  @optional_js = []
end


get '/' do
  redirect '/books' if logged_in?
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

  book_hash = {
      :title => @request["title"],
      :owner => current_user.email,
      :amazon_description => @request["amazon_description"],
      :isbn_13 => @request["isbn"]
  }

  @book_controller.create_and_save book_hash
	redirect '/books'
end

get '/add_book'do
  @optional_js << 'google_api.js'
  login_required
  haml :add_book
end

get '/books' do
  @optional_js << 'google_api.js'
  @optional_js << 'books.js'
  @optional_js << 'bootstrap_data_table.js'
  if params["query"].nil?
    @books = @book_controller.get_all
  else
    @books = @book_controller.search_for(params["query"])
  end
  haml :books
end
