class IdeasController < ApplicationController

  before_action :find_idea, only: [:show, :destroy, :edit, :update]
  before_action :authenticate_user!, only: [:destroy, :edit, :update]

  def new
  end

  def create
  end

  def show
  end

  def index
  end

  def destroy
  end

  def edit
  end

  def update
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
