# Gryphon


## Useful links for the project

Gryphon Board on Trello: https://trello.com/b/zXSgyJnf/gryphon


## Technologies

- [***Docker***](https://www.docker.com/)
 
- [***Rails***](http://rubyonrails.org/)

- [***Elastic Search***](https://www.elastic.co/)

- [***Neo4j***](https://neo4j.com/)

## Installation

### Requirements
- docker >= 1.12.1
- docker-compose >= 1.8.0
- ruby >= 2.1 & capistrano >= 3.6.1

### Quick start

Install docker and docker-compose

````
$ wget -qO- https://get.docker.com/ | sh
$ sudo usermod -aG docker $(whoami)
$ sudo apt-get -y install python-pip
$ sudo pip install docker-compose
````

Start all services

````
$ cd <project_dir>/
$ docker-compose up
````


## Deploy

Install capistrano

````
$ gem install capistrano
````

Push

````
$ cd <project_dir>/
$ cap production deploy
````