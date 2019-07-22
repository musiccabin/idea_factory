class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      render :new, alert: 'are you sure about that? if you are not a current idea factory contributer, please sign up first.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end
