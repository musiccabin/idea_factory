class ReviewsController < ApplicationController

  before_action :find_review, only: [:show, :destroy]
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :authorize, only: [:destroy]

  def create
    @review = Review.new review_params
    @review.idea = Idea.find params[:idea_id]
    @review.user = current_user
    if @review.save
      redirect_to @review.idea, notice: 'your review is published.'
    else
      render 'ideas/show'
    end
  end

  def destroy
    @review.destroy
    redirect_to @review.idea, notice: 'gone as if it never happened!'
  end

  private
  def review_params
    params.require(:review).permit(:title, :description)
  end

  def find_review
    @review = Review.find_by(id: params[:id])
  end

  def authorize
    return redirect_to @review.idea, alert: 'you can only edit or delete your own reviews' unless can?(:crud, @review)
  end
end
