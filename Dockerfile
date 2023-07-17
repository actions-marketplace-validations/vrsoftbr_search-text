FROM alpine:3.18.2

RUN apk add --no-cache --upgrade grep

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
