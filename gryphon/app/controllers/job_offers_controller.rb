class JobOffersController < ApplicationController
  before_filter :authorize, :except => [:index]

  def index
    @job_offers = JobOffer.all.to_a
  end

  def show
    # user = User.find(params[:user_id])
    @job_offer = JobOffer.find_by(id: params[:id])

    @similar_offers = JobOffer.all.to_a

    current_user.views << @job_offer if ! current_user.nil? and ! current_user.views.to_a.include?(@job_offer)

    #current_user.views << @job_offer if ! current_user.views.to_a.include?(@job_offer)
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


# MATCH (user:User {email: "pepi@abv.bg" }) - [:LIKES] -> (j)- [:SIMILAR_TO] -> (j2)
# WHERE NOT (user)-[:LIKES]->(j2)
# WITH count(j2) as baba,
# user.email as u,
# j2.name as name
# ORDER BY baba DESC
# RETURN baba, name, u

  def recommended_offers
    offers = a_session.match(u: "User {email: #{current_user.email}}")
  end

end
