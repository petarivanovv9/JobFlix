class JobOffersController < ApplicationController
  before_filter :authorize, :except => [:index]

  def index
    @job_offers = JobOffer.all.to_a
  end

  def show
    @job_offer = JobOffer.find_by(id: params[:id])

    @similar_offers = JobOffer.all.to_a

    current_user.views << @job_offer if ! current_user.nil? and ! current_user.views.include?(@job_offer)

    @is_liked = liked?(current_user, @job_offer)
  end

  def authorize
    redirect_to new_user_session_url if current_user.nil?
  end

  def like_job_offer
    job_offer = JobOffer.find_by(id: params[:id])

    current_user.likes << job_offer if ! current_user.likes.include?(job_offer)

    redirect_back fallback_location: { action: 'show' }
  end

  def dislike_job_offer
    job_offer = JobOffer.find_by(id: params[:id])

    current_user.likes(:job_offer, :LIKES).match_to(job_offer).delete_all(:LIKES)

    redirect_back fallback_location: { action: 'show' }

  end

  private

  def liked?(user, job_offer)
    user.likes.to_a.include?(job_offer)
  end

end
