require 'rspec'
require_relative '../src/book.rb'
require_relative '../src/book_controller.rb'
require_relative 'data_mapper_setup_tests'

describe 'BookController' do

	before do
		@book_controller = BookController.new
	end

	it 'should return a Book when provided with a valid JSON' do
		json ='{"title":"Some title","owner":"Some owner"}'
		some_book = @book_controller.get_book_from_json(json)
		the_book = Book.new(:title=>'Some title', :owner=>'Some owner')
		some_book.should == the_book
	end

  it 'should return a json representation of a book' do
    book = Book.new(:title=>'Some title', :owner=>'Some owner')
    the_json ='{"title":"Some title","owner":"Some owner"}'
    some_json = @book_controller.get_json_for_book(book)

    some_json.should == the_json

  end


  it 'should return a json representation of a list of book' do
    a_book = Book.new(:title=>'a title', :owner=>'a owner')
    another_book = Book.new(:title=>'another title', :owner=>'another owner')
    some_book = Book.new(:title=>'some title', :owner=>'some owner')
    list_of_books = [a_book,another_book,some_book]

    the_json ='[{"title":"a title","owner":"a owner"},{"title":"another title","owner":"another owner"},{"title":"some title","owner":"some owner"}]'
    some_json = @book_controller.get_json_for_books(list_of_books)


    some_json.should == the_json

  end

	it 'should call the Mapper to save a book when save method called' do
		mapper = double('Mapper')
		json = '{"title":"Some title","owner":"Some owner"}'
    the_book = Book.new(:title=>'Some title', :owner=>'Some owner')

    mapper.should_receive(:save_book).with(the_book)
	
		@book_controller.inject_mapper mapper
		@book_controller.save_book_from_json json
	end

  it 'should return a list of books when asked for all of them' do
    a_book = Book.new(:title=>'a title', :owner=>'a owner')
    another_book = Book.new(:title=>'another title', :owner=>'another owner')
    some_book = Book.new(:title=>'some title', :owner=>'some owner')
    list_of_books = [a_book,another_book,some_book]

    the_json ='[{"title":"a title","owner":"a owner"},{"title":"another title","owner":"another owner"},{"title":"some title","owner":"some owner"}]'

    mapper = double('Mapper',:get_all_books => list_of_books)
    @book_controller.inject_mapper mapper
    some_json = @book_controller.get_all_books

    some_json.should == the_json
  end
	
end
