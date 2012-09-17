class VotesController < ApplicationController

before_filter :authenticate

  def index
    @votes = Vote.order('created_at DESC')
  end

  def create
    if current_user.canpost
      @vote = Vote.new
      @vote.post_id = params[:post_id]
      @vote.user_id = current_user.id
      if @vote.save
        points = 10
        @vote.post.user.give_karma(points)
        render text: 'success'
      else
        render text: 'error'
      end
    end
  end

  def destroy
    if current_user.canpost
      post_id = params[:id]
      @vote = Vote.find(:first, conditions: ['user_id = ? AND post_id = ?', current_user.id, post_id])

      if @vote.destroy
        points = -10
        @vote.post.user.give_karma(points)
        render text: 'ohhh yeahh'
      else
        render text: 'error', status: 403
      end
    end
  end

  def mail
    if current_user.canpost
      @post = Post.find_by_id(params[:post_id])
      if !@post then return redirect_to :root end
      if @post.user.id == current_user.id then return redirect_to :root end
      if current_user.has_voted_on(@post) then return redirect_to :root end
      @vote = Vote.new
      @vote.post_id = @post.id
      @vote.user_id = current_user.id
      if @vote.save
        points = 10
        @vote.post.user.give_karma(points)
        redirect_to '/#'+@post.id.to_s
      else
        redirect_to :root
      end
    end
  end

end
