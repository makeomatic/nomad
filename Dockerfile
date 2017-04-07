FROM frolvlad/alpine-glibc:alpine-3.5_glibc-2.24

LABEL vendor=makeomatic \
      version_tags="[\"0.5\",\"0.5.5\"]"

ENV NOMAD_VERSION=0.5.5 \
    NOMAD_SHA256=13ecd22bbbffab5b8261c2146af54fdf96a22c46c6618d6b5fd0f61938b95068

RUN apk --no-cache --update add curl libtool coreutils

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
