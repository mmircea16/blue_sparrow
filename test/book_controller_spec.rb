require 'rspec'
require_relative '../book.rb'
require_relative '../book_controller.rb'

describe 'BookController' do

	before do
		@book_controller = BookController.new
	end

	it 'should return a Book when provided with a valid JSON' do
		json ='{"title":"Some title","owner":"Some owner"}'
		some_book = @book_controller.get_book_from_json(json)
		the_book = Book.new 'Some title', 'Some owner'
		some_book.should == the_book
	end

	it 'should call the Mapper to save a book when save method called' do
		
		mapper = double('Mapper')
		json = '{"title":"Some title","owner":"Some owner"}'
		the_book = Book.new 'Some title', 'Some owner'

		mapper.should_receive(:save_book).with(the_book)
	
		@book_controller.inject_mapper mapper
		@book_controller.save_book_from_json json

	end

	
end
