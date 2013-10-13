class PostsController < ApplicationController

  before_filter :authenticate

  def index
    if params[:user_id]
      user = User.find(params[:user_id]) 
    end
    if user 
      @posts = user.posts
    else
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to :index, notice: "Announcement was successfully created." }
      else
        format.html { redirect_to :index, notice: "Sorry, there was a problem saving your post. If you email us at hello@announcements.io we'll get back to you on the double." }
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to :index, :notice => "Announcement was successfully updated."
    else
      redirect_to :index, :notice => "Sorry, there was a problem saving your post. If you email us at hello@announcements.io we'll get back to you on the double."
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to :index
  end
end
