class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :user_match, only:[:edit, :update]


  def show
    @book = Book.find(params[:id])
    @booknew = Book.new
    @comment = Comment.new
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = current_user.books.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    book = current_user.books.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def user_match
    @book = Book.find(params[:id])
    redirect_to "/books" unless @book.user == current_user
  end
end
