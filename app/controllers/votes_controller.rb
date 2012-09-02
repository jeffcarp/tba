class VotesController < ApplicationController

before_filter :authenticate

  def index
    @votes = Vote.order('created_at DESC')
  end

  def create
    if current_user.canpost
      @vote = Vote.new
      @vote.up = params[:up]
      @vote.post_id = params[:post_id]
      @vote.user_id = current_user.id
      if @vote.save
        points = (@vote.up) ? 10 : -10
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
        points = (@vote.up) ? -10 : 10
        @vote.post.user.give_karma(points)
        render text: 'ohhh yeahh'
      else
        render text: 'error', status: 403
      end
    end
  end

end
