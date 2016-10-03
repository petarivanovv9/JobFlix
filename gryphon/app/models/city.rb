class City
  include Neo4j::ActiveNode

  id_property :name

  has_many :in, :job_offers, origin: :city, model_class: :JobOffer
  has_many :in, :users, origin: :city, model_class: :User

end
