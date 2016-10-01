class JobOffersController < ApplicationController

  def index
    @job_offers = JobOffer.all.to_a
  end

  def show
    user = User.find(params[:user_id]) if ! params[:user_id].nil?

    # user = User.find(params[:user_id])
    @job_offer = JobOffer.find_by(id: params[:id])

    user.views << @job_offer if ! user.nil? and ! user.views.to_a.include?(@job_offer)

    #user.views << @job_offer if ! user.views.to_a.include?(@job_offer)
end

  def like_job_offer
    puts params.keys

    user = User.find(params[:user_id])
    job_offer = JobOffer.find_by(id: params[:id])

    user.likes << job_offer if ! user.likes.to_a.include?(job_offer)

    redirect_back fallback_location: { action: 'show' }
  end

end
