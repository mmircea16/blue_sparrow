require 'rspec'
require_relative '../src/mapper.rb'

describe 'Mapper' do
	
	before do
		@mapper = Mapper.new	
	end

	it 'should save a book' do
		book = double(book, :save => nil)
    book.stub(:id => 2)
    book.should_receive(:save)
		@mapper.save_book book
  end

  it 'should return an id when saving a book' do
    book = double(book, :save => nil)
    book.stub(:id => 2)
    @mapper.save_book(book).should == 2
  end

end
