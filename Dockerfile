FROM alpine:3.10
LABEL creator="Brian Provenzano" \
      email="bproven@example.com"

RUN apk --no-cache update &&\
    apk --no-cache upgrade &&\
    apk --no-cache add git openssl salt-master

# auto accept any minions
RUN sed -i 's/#auto_accept: False/auto_accept: True/g' /etc/salt/master

ENTRYPOINT ["salt-master", "-l", "debug"]
