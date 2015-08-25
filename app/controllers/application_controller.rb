class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    # Confirms a signed_in user
    def signed_in_user
      unless signed_in?
        store_location # URL that user intended to go before signing in
        flash[:danger] = "Please sign in"
        redirect_to signin_url
      end
    end
  
end
