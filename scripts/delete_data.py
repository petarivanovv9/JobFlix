from neo4j.v1 import GraphDatabase, basic_auth
import json
import re
import hashlib


#
# Neo4j - Cypher
#

# driver = GraphDatabase.driver("bolt://46.101.245.130:7687", auth=basic_auth("neo4j", "neo4j"))
driver = GraphDatabase.driver("bolt://localhost:7687", auth=basic_auth("neo4j", "neo4j"))

session = driver.session()

session.run("MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r")



session.close()
