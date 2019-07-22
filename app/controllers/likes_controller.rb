class LikesController < ApplicationController

  before_action :find_idea
  before_action :authenticate_user!
  before_action :authorize

  def create
    @like = Like.new
    @like.user = current_user
    @like.idea = @idea
    if @like.save
      redirect_to @idea
    end
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @like.destroy
    redirect_to @idea
  end

  private
  def find_idea
    @idea = Idea.find params[:idea_id]
  end

  def authorize
    return redirect_to @idea, alert: "sorry, not allowed, but you can like other people's ideas though!" unless can?(:like, @idea)
  end
end
