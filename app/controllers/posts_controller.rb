class PostsController < ApplicationController

  def newest
    @posts = Post.order('created_at DESC').limit(10)
    @post = @posts.first
    @comment = Comment.new({post_id: @post.id})
    render 'posts/show'
  end

  def popular
    render json: Post.popular
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new({post_id: @post.id})
    respond_to do |format|
      format.html do 
        @aside_title = "Popular"
        @posts = Post.popular
      end 
      format.json do
        render json: @post 
      end 
    end
  end

  def upvote
    if current_user
      @post = Post.find(params[:id])
      @post.upvote(current_user) if @post
    end
    redirect_to :root 
  end

  def downvote
    if current_user
      @post = Post.find(params[:id])
      @post.downvote(current_user) if @post
    end
    redirect_to :root 
  end

  def new 
    # Check if user has already made a post for this edition
    if !current_user
      redirect_to :root
    end

    @aside_title = "Your drafts"
    @posts = current_user ? current_user.posts : []
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      redirect_to :compose, notice: "Post was successfully created."
    else
      redirect_to :compose, notice: "Sorry, there was a problem saving your post."
    end
  end

  def edit
    @posts = Post.popular
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to @post, :notice => "Announcement was successfully updated."
    else
      redirect_to :edit, :notice => "Sorry, there was a problem saving your post. If you email us at hi@colby.io we'll get back to you on the double."
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy if @post.user.id == current_user.id
    redirect_to :root
  end
end
