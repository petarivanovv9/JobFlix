class Category
  include Neo4j::ActiveNode

  id_property :name

  has_many :in, :job_offers, origin: :category, model_class: :JobOffer

end
