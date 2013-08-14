class Book
	attr_accessor :title, :owner
	
	def initialize title, owner
		@title = title
		@owner = owner
	end

	def == another_book
		@title==another_book.title and @owner==another_book.owner
	end
		
end
