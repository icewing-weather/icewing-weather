FROM    ubuntu:latest
RUN apt-get update
RUN apt-get install -y curl imagemagick unpaper
RUN mkdir /code
WORKDIR /code