class Skill
  include Neo4j::ActiveNode

  id_property :name

  has_many :in, :job_offers, origin: :skills, model_class: :JobOffer
  has_many :in, :users, origin: :skills, model_class: :User

end
