require 'rspec'
require 'data_mapper'
require_relative 'data_mapper_setup_tests'
require_relative '../src/mapper'
require_relative '../src/book_controller'

describe 'Integration with db' do

  before do
    DataMapper.finalize
    @mapper = Mapper.new
  end


  it 'should save and retrieve a book from db' do
      book = Book.new(:title => "title", :owner => "owner")
      id = @mapper.save_book book
      @mapper.get_book_by_id(id).should == book
  end

  it 'should return a list of all books from db' do
    a_book = Book.new(:title => "title one", :owner => "owner")
    another_book = Book.new(:title => "title two", :owner => "another owner")
    yet_another_book = Book.new(:title => "title three", :owner => "yet another owner")
    list_of_books = [a_book,another_book,yet_another_book]
    list_of_books.each {|book| @mapper.save_book book}
    @mapper.get_all_books.should == list_of_books
  end

  after do
    @mapper.delete_all
  end

end