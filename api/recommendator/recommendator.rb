require 'elasticsearch'
require 'json'
require 'neo4j'


SIZE_JOBS = 8
JOB_END_RESULT = 'id'
CONNECTION = 'http://neo4j:7474'


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
        client.index(index: 'jobs', type: 'job', id: job.n.id,  body: job.n.props)
      end
    end

    def make_jobs(client)
      jobs = return_from_db
      fill_jobs_elastic client, jobs
    end
  end
end

client.indices.delete(index: 'jobs')
ElasticJobs.make_jobs(client)
rec = Recommendator.new(client)
neo4j_session = Neo4j::Session.open(:server_db, CONNECTION)
all_jobs = neo4j_session.query('MATCH (n:JobOffer)  RETURN n')


def make_all_connections(jobs, rec)
  connections = {}
  jobs.each do |job|
    connections[job.n.id] = rec.find_matching_jobs(job.n.id)
  end
  connections
end

File.open('connections.json', 'w') do |f|
  f.write(make_all_connections(all_jobs, rec).to_json)
end
