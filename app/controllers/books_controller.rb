class BooksController < InheritedResources::Base

def index
	@books = Book.order('books.position ASC')
end

def sort
puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!"	
	@books = Book.all
	@books.each do |book|
	book.position = params['book'].index(book.id.to_s) + 1
	book.save
	end
	render :nothing => true
end

end
