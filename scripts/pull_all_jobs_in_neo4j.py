from neo4j.v1 import GraphDatabase, basic_auth
import json
import re
import hashlib


with open('../jobsCrawler/jobs_url.json') as data_file:
    all_jobs = json.load(data_file)


CAT_SOF_DEV = "Software Development"
CITY_SOF = "Sofia"
BUSY_FULL = "Full Time"
TYPE_PERM = "Permament"
LEVEL_EXPRTS = "Experts/Specialists"
LEVEL_EMPLOYEE = "Employee"

DATAFORMAT = '%d.%m.%Y'

# set the defualt values
for job in all_jobs:
    #job['url'] = job['url'].encode(encoding='UTF-8').decode("utf-8", "strict")
    job['url'] = hashlib.sha256(job['url'].encode()).hexdigest()
    job['identificator'] = ""
    job['category'] = CAT_SOF_DEV
    job['place'] = CITY_SOF
    job['busy'] = BUSY_FULL
    job['type'] = TYPE_PERM
    if 'Експерти/Специалисти' in job['level']:
        job['level'] = LEVEL_EXPRTS
    if 'Служители' in job['level']:
        job['level'] = LEVEL_EMPLOYEE
    if len(job['title']) > 2:
        job['title'] = job['title'][0]
    #job['identificator'] = re.sub(r"(\s+)", "_", job['title']).lower()



for job in all_jobs:
    for key in job.keys():
        if type(job[key]) is list:
            job[key] = job[key][0]
        #    print("QSHAAAAAAAAAAAAAAAAAAA")
        #    print(job[key])
        #    print(40 * '<>')
        #for item in job[key]:
        #    item = item.encode(encoding='UTF-8').decode("utf-8", "strict")
        job[key] = job[key].encode(encoding='UTF-8').decode("utf-8", "strict")
    #if len(job['title']) > 2:
    #    print("QSHAAAAAAAAAAAAAAAAAAAAAAaa")
    job['identificator'] = re.sub(r"(\s+)", "_", job['title'])
    job['identificator'] = re.sub(r"[^\w]+", "", job['identificator']).lower()


#print(all_jobs[90])

#
# Neo4j - Cypher
#

driver = GraphDatabase.driver("bolt://localhost:7687", auth=basic_auth("neo4j", "neo4j"))
session = driver.session()

session.run("MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r")


for job in all_jobs:
    # creating Company
    session.run(
        "MERGE (n:Company {name: {company_name}})",
        {'company_name': job['company']}
    )
    # creating Category
    session.run(
        "MERGE (n:Category {name: {category_name}})",
        {'category_name': job['category']}
    )
    # creating City
    session.run(
        "MERGE (n:City {name: {city_name}})",
        {'city_name': job['place']}
    )
    # creating JobOffer
    session.run(
        "MERGE (n:JobOffer {id:{id}, name:{headline}, level:{level}, busy:{busy}, type:{type}, description:{description}, publicated:{publicated}, identificator:{identificator}})",
        {
            'id': job['url'],
            'headline': job['title'],
            'level': job['level'],
            'busy': job['busy'],
            'type': job['type'],
            'description': job['description'],
            'publicated': job['publicated'],
            'identificator': job['identificator']
        }
    )
    # creating relations
    session.run(
        "MATCH (a:JobOffer), (b:Company), (c:City), (d:Category)"
        "WHERE a.name = {job_name} AND b.name = {company_name} AND c.name = {city_name} AND d.name = {category_name}"
        "MERGE (a)-[:LOCATED_IN]->(c)"
        "MERGE (a)-[:IS_IN]->(d)"
        "MERGE (a)-[:PUBLISHED_BY]->(b)",
        {
            'job_name': job['title'],
            'company_name': job['company'],
            'city_name': job['place'],
            'category_name': job['category']
        }
    )


session.close()
