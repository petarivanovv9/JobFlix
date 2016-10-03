class StaticPagesController < ApplicationController

  def home
    @companies = Company.all.to_a
    job_offers = JobOffer.all.to_a

    @num_active_job_offers = job_offers.size

    @random_job_offers = job_offers.sample(@num_active_job_offers / 2)

    @companies_jobs = Hash.new
    Company.all.each do |company|
      @companies_jobs[company.name] = company.job_offers.to_a
    end
  end

end
