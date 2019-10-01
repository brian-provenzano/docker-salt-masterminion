FROM alpine:3.10
LABEL creator="Brian Provenzano" \
      email="bproven@example.com"

RUN apk --no-cache update &&\
    apk --no-cache upgrade &&\
    apk --no-cache add git openssl salt-master

#create the default salt state tree
RUN mkdir /srv/salt

#default master config with autoaccept turned ON
COPY src/master /etc/salt/

ENTRYPOINT ["salt-master", "-l", "debug"]
