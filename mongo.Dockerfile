FROM alpine:3.9 as base

RUN apk add --no-cache mongodb mongodb-tools

VOLUME /data/db

RUN chown -R mongodb /data/db

#############################################

FROM base as seed

COPY mongo-entrypoint.sh /usr/bin

COPY ./actus-webapp/data/demos/json /data/json

ENTRYPOINT [ "/usr/bin/mongo-entrypoint.sh" ]
