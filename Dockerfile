FROM frolvlad/alpine-glibc:alpine-3.8_glibc-2.27

LABEL vendor=makeomatic \
      version_tags="[\"0.8\",\"0.8.6\"]"

ENV NOMAD_VERSION=0.8.6 \
    NOMAD_SHA256=7569561e4a8fdb283f36f9ff6ed7834be6b1f4a2149246f8bd3fb719265c800c

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
