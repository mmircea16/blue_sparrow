require 'data_mapper'
class Book

	include DataMapper::Resource
	
	property :id, Serial
	property :title, String
	property :owner, String

	def == another_book
		@title==another_book.title and @owner==another_book.owner
	end
		
end
