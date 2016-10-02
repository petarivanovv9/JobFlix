class JobOffersController < ApplicationController
  before_filter :authorize, :except => [:index]

  def index
    @job_offers = JobOffer.all.to_a
    @job_offers = recommended_offers if current_user
  end

  def show
    @job_offer = JobOffer.find_by(id: params[:id])

    @similar_offers = recommended_offers

    current_user.views << @job_offer if ! current_user.nil? and ! current_user.views.to_a.include?(@job_offer)
  end

  def authorize
    redirect_to root_path if current_user.nil?
  end

  def like_job_offer
    user_id = current_user.id
    user = User.find(user_id)
    job_offer = JobOffer.find_by(id: params[:id])

    user.likes << job_offer if ! user.likes.to_a.include?(job_offer)

    redirect_back fallback_location: { action: 'show' }
  end


  def recommended_offers
    query = User.find(current_user.id).query_as(:u)
    query = query.match("(u)-[:LIKES]->(j)-[:SIMILAR_TO]->(j2)")

    query = query.where_not(" (u)-[:LIKES]->(j2)")
    query = query.with('count(j2) as score', 'j2 as offer')

    query = query.order_by('score DESC')

    query.return('offer, score').map {|r| r.offer}
  end

end
