FROM ubuntu:21.10

RUN apt-get update && apt-get install -y init && apt-get clean all