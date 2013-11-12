class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      # TODO: Change
      redirect_to @comment.post || :root, notice: "Comment was successfully created."
    else
      redirect_to @comment.post || :root, notice: "Sorry, there was a problem saving your post."
    end
  end

  def update
  end

  def destroy
  end
end
