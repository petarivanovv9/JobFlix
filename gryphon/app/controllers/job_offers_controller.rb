class JobOffersController < ApplicationController
  before_filter :authorize, :except => [:index]

  def index
    @job_offers = JobOffer.all.to_a
    @job_offers = recommended_offers if current_user
  end

  def show
    @job_offer = JobOffer.find_by(id: params[:id])

    @recommended = recommended_offers
    @similar = similar_offers(@job_offer)

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

  def recommended_offers
    query = User.find(current_user.id).query_as(:u)
    query = query.match("(u)-[:LIKES]->(j)-[:SIMILAR_TO]->(j2)")

    query = query.where_not(" (u)-[:LIKES]->(j2)")
    query = query.with('count(j2) as score', 'j2 as offer')

    query = query.order_by('score DESC')

    recommended = query.return('offer, score').map {|r| r.offer}

    random = []
    random = (JobOffer.all.to_a - recommended).sample(50 - recommended.size) if recommended.size < 30

    recommended + random
  end

  def similar_offers(job_offer)
    job_offer.similarities.to_a
  end

  private

  def liked?(user, job_offer)
    user.likes.to_a.include?(job_offer)
  end

end
