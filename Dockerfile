FROM mhart/alpine-node:6.4.0
MAINTAINER David Asabina <vid@bina.me>
ARG version
RUN npm install -g serverless@${version}
VOLUME /home/.aws
VOLUME /home/serverless
WORKDIR  /home/serverless
