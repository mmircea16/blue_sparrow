require 'rspec'
require_relative '../src/book.rb'
require_relative '../src/book_controller.rb'
require_relative 'data_mapper_setup_tests'

describe 'BookController' do

	before do
		@book_controller = BookController.new
	end

  it 'should create a book' do
    book_hash = {:title => "title" , :owner => "owner"}
    the_book = double("Book")
    the_book.stub(:save!).and_return(the_book)
    Book.stub(:new).and_return(the_book)

    the_book.should_receive(:save!)

    @book_controller.create_and_save(book_hash).should == the_book

  end

  it 'should get all the books' do
    list = ["a book"]
    Book.stub(:all).and_return(list)
    @book_controller.get_all.should == list
  end
	
end
