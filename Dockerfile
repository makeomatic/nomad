FROM frolvlad/alpine-glibc:alpine-3.5_glibc-2.24

LABEL vendor=makeomatic \
      version_tags="[\"0.5\",\"0.5.6\"]"

ENV NOMAD_VERSION=0.5.6 \
    NOMAD_SHA256=3f5210f0bcddf04e2cc04b14a866df1614b71028863fe17bcdc8585488f8cb0c

RUN apk --no-cache --update add curl libtool coreutils tzdata

RUN curl -sSL -o /tmp/nomad.zip https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip && \
    echo "${NOMAD_SHA256}  /tmp/nomad.zip" | sha256sum -c - && unzip /tmp/nomad.zip -d /usr/local/bin && \
    rm -rf /tmp/*

VOLUME ["/data", "/config"]

# http server: 4646 (applies to server+client)
# rpc raft: 4647 (applies to server+client)
# serf gossip: 4648 TCP+UDP (applies to server)

EXPOSE 4646 4647 4648

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
