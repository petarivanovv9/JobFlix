FROM node:6.6.0
MAINTAINER Georgi Kiryakov <george.kiryakov@gmail.com>

RUN apt-get update && apt-get install -qq -y build-essential --fix-missing --no-install-recommends

ENV INSTALL_PATH /webclient
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY package.json package.json
RUN npm install

COPY . .

VOLUME ["$INSTALL_PATH/node_modules"]

CMD npm run production