class CommentsController < ApplicationController

  respond_to :html, :js, :json

  def new
    @micropost = Micropost.find(params[:id])
    @comment = Comment.new
    respond_with(@comment)
  end

  def create
    @comment = Comment.new( params[:comment] )

    if @comment.save
      respond_with do |format|
        format.html do
          if request.xhr?
            render :partial => "microposts/show", :locals => { :comment => @comment }, :layout => false, :status => :created
          else
            redirect_to @comment
          end
        end
      end
    else
      respond_with do |format|
        format.html do
          if request.xhr?
            render :json => @comment.errors, :status => :unprocessable_entity
          else
            render :action => :new, :status => :unprocessable_entity
          end
        end
      end
    end
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