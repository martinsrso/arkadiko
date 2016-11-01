FROM golang:1.6.2-alpine

MAINTAINER TFG Co <backend@tfgco.com>

EXPOSE 8890

RUN apk update
RUN apk add git apache2-utils make g++

RUN go get -u github.com/Masterminds/glide/...

ADD . /go/src/github.com/topfreegames/arkadiko

WORKDIR /go/src/github.com/topfreegames/arkadiko
RUN glide install
RUN go install github.com/topfreegames/arkadiko

ENV ARKADIKO_MQTTSERVER_HOST localhost
ENV ARKADIKO_MQTTSERVER_PORT 1883
ENV ARKADIKO_MQTTSERVER_USER admin
ENV ARKADIKO_MQTTSERVER_PASS admin
ENV ARKADIKO_REDIS_HOST localhost
ENV ARKADIKO_REDIS_PORT 6379
ENV ARKADIKO_REDIS_MAXPOLLSIZE 20
ENV ARKADIKO_REDIS_PASSWORD ""
ENV USE_BASICAUTH false
ENV ARKADIKO_BASICAUTH_USERNAME ""
ENV ARKADIKO_BASICAUTH_PASSWORD ""

CMD /go/bin/arkadiko start --bind 0.0.0.0 --port 8890 --config ./config/local.yml
