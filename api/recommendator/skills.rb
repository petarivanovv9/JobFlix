CONNECTION = 'http://10.255.255.72:7474'
SIZE_JOBS = 8
client = Elasticsearch::Client.new host: 'http://elasticsearch:9200'
JOB_END_RESULT = 'id'


def get_skills()
  neo4j_session = Neo4j::Session.open(:server_db, CONNECTION)
  skills = neo4j_session.query('MATCH (n:Skill)  RETURN n')
end

class OffersToSkill

  def initialize(client)
    @client = client
  end

  def find_elastic(skill)
    @client.search index: 'jobs', body: {
      query: {
        more_like_this: {
          fields: ['description'],
          like_text: skill,
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

  def offers_to_skill(skill)
    refine_jobs(find_elastic(skill))
  end
end

skills = get_skills
rec = OffersToSkill.new(client)
result = {}
skills.each { |skill| result[skill] = rec.offers_to_skill(skill.n.props[:name].downcase) }

File.open('skill-offers.json', 'w') do |f|
  f.write(result.to_json)
end


