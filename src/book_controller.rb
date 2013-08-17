require 'json'
require_relative 'book.rb'
class BookController

	def get_book_from_json json
		parsed_data = JSON.parse(json)
		Book.new(:title => parsed_data['title'], :owner => parsed_data['owner'])
	end

	def inject_mapper mapper
		@mapper = mapper
	end

	def save_book_from_json json
		@mapper.save_book get_book_from_json json
	end

  def get_json_for_book(book)
    JSON.dump({"title" => book.title, "owner" => book.owner})
  end

  def get_json_for_books(list_of_books)
    list = list_of_books.collect {|book| {"title" => book.title, "owner" => book.owner} }
    JSON.dump list
  end

  def get_all_books
    get_json_for_books @mapper.get_all_books
  end

end
