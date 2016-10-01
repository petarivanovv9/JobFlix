class JobOffer
  include Neo4j::ActiveNode

  id_property :id
  property :identificator

  property :name
  property :level
  property :busy
  property :type
  property :description
  property :publicated

  has_one :out, :city, type: :LOCATED_IN, model_class: :City
  has_one :out, :company, type: :PUBLISHED_BY, model_class: :Company
  has_one :out, :category, type: :IS_IN, model_class: :Category

  has_many :out, :skills, type: :REQUIRES, model_class: :Skill

  # JobOffer is liked by User, JobOffer <- User
  has_many :in, :liked_by, origin: :likes, model_class: :User
  # JobOffer is viewed by User, JobOffer <- User
  has_many :in, :viewed_by, origin: :views, model_class: :User
end
