class StaticPagesController < ApplicationController
  
  def home
    if signed_in?
      @headache = current_user.headaches.build if signed_in?
      @headaches = current_user.headaches.paginate(page: params[:page])
    end
  end

end
