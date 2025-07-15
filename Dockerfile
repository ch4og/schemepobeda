FROM alpine:latest

RUN apk add --no-cache guile

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

WORKDIR /app

COPY . . 

EXPOSE 8080

CMD ["guile", "server.scm"]
