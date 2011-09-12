class PostsController < ApplicationController
  def index
    per_page = params[:format] == 'atom' ? 25 : Post.per_page
    @posts = Post.published.recent.page(params[:page]).per(per_page)
  
    respond_to do |format|
      format.html
      format.xml  { render xml: @posts }
      format.json { render json: @posts }
      format.atom
    end
  end

  def show
    @post = Post.published.where(permalink: params[:id]).first
    
    respond_to do |format|
      format.html
      format.xml  { render xml: @post }
      format.json { render json: @post }
    end
  end
end
