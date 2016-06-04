# Dockerized nomad distribution

Its essential that glibc wrapper is available over muslc, otherwise nomad will say its not available
You can get it at https://github.com/andyshinn/alpine-pkg-glibc
Note that this repo needs a maintainer

## Notes

1. https://github.com/gliderlabs/docker-alpine/issues/97, `coreutils` module is needed for fingerprinting of node in client mode
