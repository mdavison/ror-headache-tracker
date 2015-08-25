class HeadachesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @headache = current_user.headaches.build(headache_params)
    if @headache.save
      flash[:success] = "Headache saved"
      redirect_to root_url
    else
      @headaches = []
      render 'static_pages/home'
    end
  end

  def destroy
    @headache.destroy
    flash[:success] = "Headache record deleted"
    redirect_to request.referrer || root_url
  end

  private

    def headache_params
      params.require(:headache).permit(:headache_date)
    end

    def correct_user
      @headache = current_user.headaches.find_by(id: params[:id])
      redirect_to root_url if @headache.nil?
    end

end
