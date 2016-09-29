class StaticPagesController < ApplicationController

  def home

    @cities = City.all.to_a
    @job_offers = JobOffer.all.to_a

    @sofia_job_offers = JobOffer.where(city: @cities.first).to_a

    @companies = Hash.new

    Company.all.each do |company|
      @companies[company.name] = company.job_offers.to_a
    end


  end

end
