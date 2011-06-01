class CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])
    @title = "should be first ~100 characters in post"
  end

  def create
    store_referer
    @comment = current_user.comments.build(params[:comment])
    if @comment.save
      flash[:success] = "Comment posted!"
      @comment.send_notification
      redirect_to (@comment.parent ? @comment.parent : @comment.link)
    else
      @title = "whouls be first ~100 characters in post"
      redirect_back_or root_path
    end
  end
  
  def destroy
    @comment.destroy
  end


end
