class JobOffersController < ApplicationController

  def index
    @job_offers = JobOffer.all.to_a
  end

  def show
    @job_offer = JobOffer.find(params[:name])
  end

  def like_job_offer
    puts params

    user = User.find(params[:user_id])
    job_offer = JobOffer.find(params[:job_offer_name])

    user.likes << job_offer if ! user.likes.to_a.include?(job_offer)

    redirect_back fallback_location: { action: 'show' }
  end

end
