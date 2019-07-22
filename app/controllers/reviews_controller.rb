class ReviewsController < ApplicationController

  before_action :find_review, only: [:show, :destroy]
  before_action :authenticate_user!, only: [:destroy]

  def new
  end

  def create
  end

  def destroy
  end

  private
  def review_params
    params.require(:review).permit(:title, :description)
  end

  def find_review
    @review = Review.find_by(id: params[:id])
  end

  def authorize
    redirect_to @review.idea, alert: 'you can only edit or delete your own reviews' unless can?(:crud, @review)
  end
end
