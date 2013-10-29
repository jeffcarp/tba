class PostsController < ApplicationController

  before_filter :authenticate

  def show
    @post = Post.find(params[:id])
    @posts = Post.find(:all, joins: [:issue, :user], limit: 10)
  end

  def compose
    # If they don't have a name, tell them to make one
    if !current_user.name
      redirect_to :settings, notice: "Hey, you need to fill in your name before you post anything."
      return
    end

    if !current_user.canpost
      redirect_to :settings, notice: "Sorry, you must have a colby.edu email address to post."
      return
    end

    # Get upcoming edition
    @issue = Issue.upcoming_issue

    # Check if user has already made a post for this edition
    @post = Post.find(:first, :conditions => ['user_id=? AND issue_id=?', current_user.id, @issue.id])

    if @post
      @already = true
      render :action => 'new', :template => 'posts/compose'
    else
      @post = Post.new
      @post.anon = false
      render :action => 'edit', :template => 'posts/compose'
    end
  end

  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to :compose, notice: "Announcement was successfully created." }
      else
        format.html { redirect_to :compose, notice: "Sorry, there was a problem saving your post. If you email us at hi@colby.io we'll get back to you on the double." }
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to :tomorrow, :notice => "Announcement was successfully updated."
    else
      redirect_to :compose, :notice => "Sorry, there was a problem saving your post. If you email us at hi@colby.io we'll get back to you on the double."
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to :compose
  end
end
