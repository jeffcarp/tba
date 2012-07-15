class PostsController < ApplicationController

  before_filter :authenticate

  def compose
    # Get upcoming edition
    @issue = Issue.upcoming_issue

    # Check if user has already made a post for this edition
    @post = Post.find(:first, :conditions => ['user_id=? AND issue_id=?', current_user.id, @issue.id])
    
    if @post    
      @already = true  
      render :action => 'new', :template => 'posts/compose'
    else
      @post = Post.new
      render :action => 'edit', :template => 'posts/compose'
    end
  end

  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to :compose, notice: 'Announcement was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to :compose, :notice => "Announcement was successfully updated."
    else
      redirect_to :compose, :notice => "Sorry, there was a problem saving your post."
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to :compose
  end
end
