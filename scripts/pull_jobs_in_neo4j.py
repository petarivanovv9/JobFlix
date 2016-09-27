from neo4j.v1 import GraphDatabase, basic_auth


driver = GraphDatabase.driver("bolt://localhost:7472", auth=basic_auth("neo4j", "neo4j"))
session = driver.session()



session.close()
