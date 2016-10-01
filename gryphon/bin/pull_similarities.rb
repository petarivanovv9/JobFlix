# require 'json'
# require 'neo4j'
#
#
# CONNECTION = 'http://neo4j:7474'
#
# file = File.read('connections.json')
#
# data_hash = JSON.parse(file)
# neo4j_session = Neo4j::Session.open(:server_db, CONNECTION)
#
# JobOffer.all.each do |job|
#   ids = data_hash[job.id]
#   p job.id
#   ids.each do |id|
#      other_job = JobOffer.find_by(id: id)
#      puts job.id
#      puts "HOOOOOOOOOOOOOOOOOOOOOOOOOO"
#      puts id
#      puts "QSHAAAAAAAAAAAAAAAAAAAAAAAAAA"
#      query = 12
#      query = "MATCH (a:JobOffer), (b:JobOffer) WHERE a.id = {job_1_id} AND b.id = {job_2_id} MERGE (a)-[:SIMILAR_TO]->(b)"
#      r = neo4j_session.query(query, job_1_id: job.id, job_2_id: other_job.id)
#      puts r
#                           # {
#                           #   'job_1_id': job.id,
#                           #   'job_2_id': other_job.id
#                           # }
#
#
#      #Neo4j::Relationship.new(:similarities, job, other_job)
#      #job.outgoing(:similarities) << other_job
#      #Neo4j
#      #job.both(:similarities) << other_job
#      #puts other_job.methods - Object.methods
#      #job.similarities << other_job if ! job.similarities.to_a.include?(other_job)
#   end
# end
#
#
#
#
# #user.views << @job_offer if ! user.nil? and ! user.views.to_a.include?(@job_offer)
