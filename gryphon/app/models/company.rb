class Company
  include Neo4j::ActiveNode

  id_property :name

  has_many :in, :job_offers, origin: :company, model_class: :JobOffer

end
