from neo4j.v1 import GraphDatabase, basic_auth

from datetime import datetime
import re

job_1 = {
    "title": "Senior .NET Developers",
    "category": "\u0418\u0422 - \u0420\u0430\u0437\u0440\u0430\u0431\u043e\u0442\u043a\u0430/\u043f\u043e\u0434\u0434\u0440\u044a\u0436\u043a\u0430 \u043d\u0430 \u0441\u043e\u0444\u0442\u0443\u0435\u0440",
    "level": "\u0415\u043a\u0441\u043f\u0435\u0440\u0442\u0438/\u0421\u043f\u0435\u0446\u0438\u0430\u043b\u0438\u0441\u0442\u0438",
    "busy": "\u041f\u044a\u043b\u043d\u043e \u0440\u0430\u0431\u043e\u0442\u043d\u043e \u0432\u0440\u0435\u043c\u0435",
    "place": "\u0421\u043e\u0444\u0438\u044f / \u0411\u044a\u043b\u0433\u0430\u0440\u0438\u044f",
    "type": "\u041f\u043e\u0441\u0442\u043e\u044f\u043d\u043d\u0430 \u0440\u0430\u0431\u043e\u0442\u0430",
    "publicated": "23.09.2016",
    "description": "As we are currently growing our development team in Sofia, we are looking\nto hire skilled FullStack .NET developers eager to work on a variety of in-\nhouse projects and technologies according to the highest development\nstandards. As part of our team you will have the opportunity to use your\ncreativity and technical skills to develop and transform our leading platform\nand brands also take part in many other projects.  \n  \n  \nWhat you will be doing:  \n  \n\u2022 You will participate in the development of web applications using Web Forms\nand MVC.  \n\u2022 Collaborate with other team members to share ideas and coordinate efforts to\nensure that project deliverables are met within specific time frame.  \n\u2022 Estimate, track and implement development tasks  \n  \nWhat you need for this position:  \n  \n\u2022 At least 5+ years of .Net / C# experience with Web applications  \n  \nRequired experience with:  \n  \no ASP.Net, Web Services, WCF, Web API  \no JavaScript, Angular, HTML 5, CSS, Ajax-  \no Minimum 2-3 years in backend software design in SQL Server , Stored\nprocedures, ++ASP.NET, C# , PHP  \no Languages: C#, SQL/T-SQL, JavaScript/DHTML, VBScript, HTML, XML,PHP-  \no Some experience with front end UI design preferred  \n  \n\u2022 Experience in Object Oriented Design and Programming, Multi-threading, web\nservices  \n\u2022 Knowledge and experience in Design Patterns &amp; Principles, System\nArchitecture and Distributed systems  \n\u2022 Ability to complete all phases of software development life cycle with\nminimal supervision  \n\u2022 Bachelor or higher degree in Computer Science or equivalent  \n\u2022 Ability to develop large scale web/database applications and to work on\nmultiple projects with multiple deadlines.  \n\u2022 Ability to communicate clearly with business users and project manager.  \n\u2022 Ability to innovate and provide functional applications with intuitive\ninterfaces.  \n\u2022 Excellent personal and communication skills  \n\u2022 English language skills on advanced level  \n  \n  \nIf you are willing to work in a fast paced, highly collaborative, dynamic work\nenvironment, then this is the right place for you! Please send us your CV in\nEnglish. Keep in mind that only shortlisted candidates will be contacted.",
    "company": "\u0424\u0438\u0440\u043c\u0430/\u041e\u0440\u0433\u0430\u043d\u0438\u0437\u0430\u0446\u0438\u044f \u0434\u0438\u0440\u0435\u043a\u0442\u043d\u043e \u0442\u044a\u0440\u0441\u0435\u0449\u0430 \u0441\u043b\u0443\u0436\u0438\u0442\u0435\u043b\u0438."
}

job_2 = {
    "title": "Software Engineer",
    "category": "\u0418\u0422 - \u0420\u0430\u0437\u0440\u0430\u0431\u043e\u0442\u043a\u0430/\u043f\u043e\u0434\u0434\u0440\u044a\u0436\u043a\u0430 \u043d\u0430 \u0441\u043e\u0444\u0442\u0443\u0435\u0440",
    "level": "\u0415\u043a\u0441\u043f\u0435\u0440\u0442\u0438/\u0421\u043f\u0435\u0446\u0438\u0430\u043b\u0438\u0441\u0442\u0438",
    "busy": "\u041f\u044a\u043b\u043d\u043e \u0440\u0430\u0431\u043e\u0442\u043d\u043e \u0432\u0440\u0435\u043c\u0435",
    "place": "\u0421\u043e\u0444\u0438\u044f / \u0411\u044a\u043b\u0433\u0430\u0440\u0438\u044f",
    "type": "\u041f\u043e\u0441\u0442\u043e\u044f\u043d\u043d\u0430 \u0440\u0430\u0431\u043e\u0442\u0430",
    "publicated": "21.09.2016",
    "description": "This is a fantastic opportunity to join our Software Development team based\nin our Office in Sofia.  \nWe are looking for an exceptional individual whose key responsibilities will\nbe to:  \n\u2022 Design and develop web applications in a multi-tier Java EE environment  \n\u2022 Support database schemas designs and query optimization  \n\u2022 Identify and apply appropriate modern technologies and techniques for\nsoftware development  \nYou should be able to demonstrate at least 1 year on the job working\nexperience with Java EE and Enterprise Design patterns. Advance experience in\nrelational database design and SQL is essential. Team player with strong\ncommunication skills and fluent in English are also expected. You should\npossess a BSc or similar computer/engineering degree. Key qualifications are:  \n\u2022 Experience in MVC model and good knowledge on the following technologies:\nSpring, Struts2, Hibernate, Ibatis, Maven  \n\u2022 Experience in relational database design and SQL  \n\u2022 Knowledge of XML, XSL, CSS/3, Javascript  \nIf you want to make a difference and work with a top-rated team of talented\nindividuals, come and join us. We offer a friendly, diverse work environment\nand a very competitive benefits package.  \nIf this position is of interest to you and match your background and career\nneeds, we can\u2019t wait to hear from you! Please send your CV",
    "company": "\u0424\u0438\u0440\u043c\u0430/\u041e\u0440\u0433\u0430\u043d\u0438\u0437\u0430\u0446\u0438\u044f \u0434\u0438\u0440\u0435\u043a\u0442\u043d\u043e \u0442\u044a\u0440\u0441\u0435\u0449\u0430 \u0441\u043b\u0443\u0436\u0438\u0442\u0435\u043b\u0438."
}

jobs = [job_1, job_2]

job_1['company'] = "РЕГУЛУС СЪРВИСИЗ ЕООД"
job_2['company'] = "МОТИВИАН ЕООД"

CAT_SOF_DEV = "Software Development"
CITY_SOF = "Sofia"
BUSY_FULL = "Full Time"
TYPE_PERM = "Permament"
LEVEL_EXPRTS = "Experts/Specialists"

DATAFORMAT = '%d.%m.%Y'

job_1['identificator'] = ""
job_2['identificator'] = ""

for job in jobs:
    for key in job_1.keys():
        job[key] = job[key].encode(encoding='UTF-8').decode("utf-8", "strict")
    job['category'] = CAT_SOF_DEV
    job['place'] = CITY_SOF
    job['busy'] = BUSY_FULL
    job['type'] = TYPE_PERM
    job['level'] = LEVEL_EXPRTS

    job['identificator'] = re.sub(r"(\s+)", "_", job['title']).lower()
    # datatime is not supported in neo4j yet
    # job['publicated'] = datetime.strptime(job['publicated'], DATAFORMAT)
    # print(job)
    # print(50 * '<>')

#
# Neo4j - Cypher
#

driver = GraphDatabase.driver("bolt://localhost:7687", auth=basic_auth("neo4j", "neo4j"))
session = driver.session()

# session.run("MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r")

for job in jobs:
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
        "MERGE (n:JobOffer {name:{headline}, level:{level}, busy:{busy}, type:{type}, description:{description}, publicated:{publicated}, identificator:{identificator}})",
        {
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
