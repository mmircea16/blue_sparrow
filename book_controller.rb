require 'json'
class BookController

	def get_book_from_json json
		parsed_data = JSON.parse(json)
		Book.new(parsed_data['title'], parsed_data['owner'])
	end

	def inject_mapper mapper
		@mapper = mapper
	end

	def save_book_from_json json
		@mapper.save_book get_book_from_json json
	end

end
