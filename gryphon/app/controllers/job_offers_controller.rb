class JobOffersController < ApplicationController

  def show
    @job_offer = JobOffer.find(params[:name])
  end

end
