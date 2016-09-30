FROM ruby:2.3.1-slim
MAINTAINER Georgi Kiryakov <george.kiryakov@gmail.com>

RUN apt-get update && apt-get install -qq -y build-essential nodejs --fix-missing --no-install-recommends

ENV INSTALL_PATH /gryphon
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile
RUN bundle install

COPY . .

# RUN bundle exec rake RAILS_ENV=production NEO4J_URL=http://neo4j:7474 DISABLE_NEO4J_SESSION=true assets:precompile

VOLUME ["$INSTALL_PATH/public"]

# CMD bundle exec puma -c config/puma.rb
CMD bash ./start_puma
