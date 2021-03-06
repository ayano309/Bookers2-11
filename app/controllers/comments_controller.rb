class CommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.comments.new(comment_params)
    @comment.book_id = @book.id
    unless @comment.save
      render 'error'  #comments/error.js.erbを参照する 
    end
      #redirect_to request.referer
      #comments/create.js.erbを参照する
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    comment = @book.comments.find(params[:id])
    comment.destroy
    #redirect_to request.referer
    #comments/destroy.js.erbを参照する
  end


  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
