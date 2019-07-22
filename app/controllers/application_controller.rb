class ApplicationController < ActionController::Base
    def current_user
        User.find_by(id: session[:user_id])
    end
    
    helper_method :current_user

    def authenticate_user!
        redirect_to new_session_path, alert: 'you must sign in to access this page.' unless current_user
    end
end
