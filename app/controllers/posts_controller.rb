class PostsController < ApplicationController

  def new
    # Get upcoming edition
    @issue = Issue.upcoming_issue

    # Check if user has already made a post for this edition
    @post = Post.find(:first, :conditions => ['user_id=? AND issue_id=?', current_user.id, @issue.id])
    
    if @post    
      @already = true  
    else
      @post = Post.new
    end
  end

  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to :compose, notice: 'Post was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    redirect_to :compose, :notice => "Announcement was successfully updated."
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to :compose
  end
end
