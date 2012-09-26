class CommentsController < ApplicationController

  respond_to :html, :js

  def new
    @micropost = Micropost.find(params[:id])
    @comment = Comment.new
    respond_with(@comment)
  end

  def create
    @comment = Comment.new(params[:comment])
    flash[:notice] = 'Comment was successfully created.' if @comment.save
    respond_with(@comment, :location => comments_path)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_with(@comment) do |format|
      format.js { render :nothing => true }
    end
  end

  def add_comment
    @micropost = Micropost.find(params[:micropost_id])
    @comment= @micropost.comments.create(:content => params[:comment][:content])
    redirect_to micropost_path(@micropost)
  end

end