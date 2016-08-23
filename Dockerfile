FROM mhart/alpine-node:6.4.0
MAINTAINER David Asabina <vid@bina.me>
ARG version=v0.5.4
RUN npm install -g serverless@${version}
VOLUME ~/.aws/credentials
VOLUME ~/serverless
WORKDIR  ~/serverless
