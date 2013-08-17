require 'data_mapper'
require_relative 'book'
require_relative 'data_mapper_setup'

class Mapper

	def initialize 
		
	end

	def save_book book
		book.save
    book.id
	end

	def get_book_by_id id
    Book.get(id)
  end

  def get_all_books
    Book.all
  end

  def delete_all
    Book.all.each {|book| book.destroy}
  end

end
