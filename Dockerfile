FROM gliderlabs/alpine:3.3

ENV NOMAD_VERSION=0.3.2 \
    NOMAD_SHA256=710ff3515bc449bc2a06652464f4af55f1b76f63c77a9048bc30d6fde284b441

RUN apk --no-cache --update add --virtual build-dependencies ca-certificates wget && \
    wget -O /nomad_${NOMAD_VERSION}_linux_amd64.zip https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip && \
    echo "${NOMAD_SHA256}  nomad_${NOMAD_VERSION}_linux_amd64.zip" > /nomad.sha256 && \
    sha256sum -c /nomad.sha256 && \
    cd /usr/local/bin && \
    unzip /nomad_${NOMAD_VERSION}_linux_amd64.zip && \
    apk del build-dependencies && \
    rm -rfv /nomad*

VOLUME ["/data", "/config"]

ENTRYPOINT ["/usr/local/bin/nomad", "agent"]

CMD ["-config=/config"]
