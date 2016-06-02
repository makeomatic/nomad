FROM gliderlabs/alpine:3.3

ENV NOMAD_VERSION=0.3.2 \
    NOMAD_SHA256=710ff3515bc449bc2a06652464f4af55f1b76f63c77a9048bc30d6fde284b441

RUN apk --no-cache --update add --virtual build-dependencies ca-certificates wget && \
    wget -q -O /etc/apk/keys/andyshinn.rsa.pub https://raw.githubusercontent.com/andyshinn/alpine-pkg-glibc/master/andyshinn.rsa.pub && \
    wget https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.23-r1/glibc-2.23-r1.apk && \
    apk add glibc-2.23-r1.apk && \
    wget -O /nomad_${NOMAD_VERSION}_linux_amd64.zip https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip && \
    echo "${NOMAD_SHA256}  nomad_${NOMAD_VERSION}_linux_amd64.zip" > /nomad.sha256 && \
    sha256sum -c /nomad.sha256 && \
    cd /usr/local/bin && \
    unzip /nomad_${NOMAD_VERSION}_linux_amd64.zip && \
    apk del build-dependencies && \
    rm -rfv /nomad* /etc/apk/keys/andyshinn.rsa.pub

VOLUME ["/data", "/config"]

# http: The port used to run the HTTP server. Applies to both client and server nodes.
# Defaults to 4646.

# rpc: The port used for internal RPC communication between agents and servers, and for inter-server traffic for the
# consensus algorithm (raft). Defaults to 4647. Only used on server nodes.

# serf: The port used for the gossip protocol for cluster membership. Both TCP and UDP should be routable between
# the server nodes on this port. Defaults to 4648. Only used on server nodes.

EXPOSE 4646 4647 4648

ENTRYPOINT ["/usr/local/bin/nomad", "agent"]

CMD ["-config=/config"]
