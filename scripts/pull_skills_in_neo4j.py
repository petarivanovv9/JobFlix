from neo4j.v1 import GraphDatabase, basic_auth

IT_SKILLS = [
    "Ruby", "ASP.NET", "AJAX", "Objective-C", "PHP", "Python",
    "Perl", "C", "C++", "C#", "XML", "JavaScript", "HTML", "Java", "SQL", "Django",
    "Rails", "iOS", "Linux", ".NET", "Cloud", "HTML", "CSS"
]

MANAGEMENT_SKILL = [
    "Problem solving", "Timemanagement", "English", "Project Management",
    "Marketing", "Recruitment", "Sales", "Team player", "E-commerce",
    "Supervising", "Communication", "Management discipline", "Project tracking systems"
]


#
# Neo4j - Cypher
#

driver = GraphDatabase.driver("bolt://localhost:7687", auth=basic_auth("neo4j", "neo4j"))
session = driver.session()

for it_skill in IT_SKILLS:
    session.run(
        "MERGE (n:Skill {name: {it_skill_name}})",
        {'it_skill_name': it_skill}
    )

for mang_skill in MANAGEMENT_SKILL:
    session.run(
        "MERGE (n:Skill {name: {mang_skill_name}})",
        {'mang_skill_name': mang_skill}
    )

session.close()
