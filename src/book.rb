require 'data_mapper'
class Book

	include DataMapper::Resource
	
	property :id, Serial
	property :title, String
	property :owner, String
  property :amazon_description, String, :default => '', :length => 150
  property :isbn_13, String, :default => '', :length => 150
  property :cover, String, :default => '', :length => 150
  property :google_books_description, String, :default => '', :length => 150

	def == another_book
		@title==another_book.title and @owner==another_book.owner
	end
		
end
