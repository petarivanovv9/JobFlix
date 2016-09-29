class JobOffer
  include Neo4j::ActiveNode

  id_property :name
  property :level
  property :busy
  property :type
  property :description
  property :publicated

  has_one :out, :city, type: :LOCATED_IN, model_class: :City
  has_one :out, :company, type: :PUBLISHED_BY, model_class: :Company
  has_one :out, :category, type: :IS_IN, model_class: :Category

end
