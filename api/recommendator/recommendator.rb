require 'elasticsearch'
require 'json'
require 'neo4j'


SIZE_JOBS = 8
JOB_END_RESULT = 'id'
CONNECTION = 'http://10.255.255.72:7474'


client = Elasticsearch::Client.new host: 'http://elasticsearch:9200'

# Gets similar jobs to a certain job
class Recommendator

  def initialize(client)
    @client = client
  end

  def find_matching_jobs(job_id)
    refine_jobs(find_elastic(job_id))
  end

  def find_elastic(job_id)
    @client.search index: 'jobs', body: {
      query: {
        more_like_this: {
          fields: ['description'],
          like: [
            _index: 'jobs',
            _type: 'job',
            _id: job_id
          ],
          min_term_freq: 1,
          min_doc_freq: 1
        }
      },
      size: SIZE_JOBS
    }
  end

  def refine_jobs(jobs)
    jobs['hits']['hits'].map { |r| r['_source'][JOB_END_RESULT] }
  end
end


# Get the data from the db and then fills the documents for Elastic
class ElasticJobs
  class << self
    def return_from_db
      neo4j_session = Neo4j::Session.open(:server_db, CONNECTION)
      neo4j_session.query('MATCH (n:JobOffer)  RETURN n')
    end

    def fill_jobs_elastic(client, jobs)
      jobs.each do |job|
        client.index(index: 'jobs', type: 'job', body: job.n.props)
      end
    end

    def make_jobs(client)
      jobs = return_from_db
      fill_jobs_elastic client, jobs
    end
  end
end

ElasticJobs.make_jobs(client)
# all_ids = ["AVeASEeoiY9WGzHANWU4", "AVeASEjuiY9WGzHANWU8", "AVeASElCiY9WGzHANWU9", "AVeASEuviY9WGzHANWVF", "AVeASEhJiY9WGzHANWU6", "AVeASEmfiY9WGzHANWU-", "AVeASEnpiY9WGzHANWU_", "AVeASEpziY9WGzHANWVB", "AVeASESviY9WGzHANWU3", "AVeASEifiY9WGzHANWU7"]
# all_ids.each do |job_id|
rec = Recommendator.new(client)
#results = rec.find_matching_jobs("AVeAb5twiY9WGzHANWWP")
#puts "Ehooo"
#puts results.count
#puts results
# end
#job_id = "AVeASEeoiY9WGzHANWU4"
#AVeAb5twiY9WGzHANWWP

all_jobs = client.search(index: 'jobs', body: { query: { match_all: {} } })['hits']['hits']

def make_all_connections(jobs, rec)
  connections = {}
  jobs.each do |job|
    connections[job["_source"]["id"]] = rec.find_matching_jobs(job["_id"])
  end
  connections
end

puts make_all_connections(all_jobs, rec)

