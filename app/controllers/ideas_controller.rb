class IdeasController < ApplicationController

  before_action :find_idea, only: [:show, :destroy, :edit, :update]
  before_action :authenticate_user!, only: [:destroy, :edit, :update]

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new idea_params
    @idea.user = current_user
    if @idea.save
      redirect_to @idea
    else
      render :new
    end
  end

  def show
  end

  def index
    @ideas = Idea.all.order(created_at: :desc)
  end

  def destroy
    @idea.destroy
    redirect_to root_path, notice: 'your idea is gone. give us your new idea when it comes!'
  end

  def edit
  end

  def update
    if @idea.update idea_params
      redirect_to @idea, notice: 'your freshly updated idea is here!'
    else
      render :edit
    end
  end

  private
  def idea_params
    params.require(:idea).permit(:title, :description)
  end

  def find_idea
    @idea = Idea.find_by(id: params[:id])
  end

  def authorize
    redirect_to @idea, alert: 'you can only edit or delete your own ideas' unless can?(:crud, @idea)
  end
end
