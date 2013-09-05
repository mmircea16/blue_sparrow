require 'json'
require_relative 'book.rb'
class BookController

  def get_all
    Book.all
  end

  def create_and_save book_hash
    book = Book.new book_hash
    book.save!
  end

  def search_for(query)
    Book.all( :title.ilike => "%#{query}%" )
  end


end
