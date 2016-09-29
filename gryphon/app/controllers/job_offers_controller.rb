class JobOffersController < ApplicationController

  def index
    @job_offers = JobOffer.all.to_a
  end

  def show
    @job_offer = JobOffer.find(params[:name])
  end

end
