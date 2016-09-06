[![Build Status](https://travis-ci.org/makeomatic/nomad.svg?branch=master)](https://travis-ci.org/makeomatic/nomad) [![DockerHub](https://img.shields.io/badge/docker-available-blue.svg)](https://hub.docker.com/r/makeomatic/nomad) [![DockerHub](https://img.shields.io/docker/pulls/makeomatic/nomad.svg)](https://hub.docker.com/r/makeomatic/nomad)

# Nomad container

Provides latest nomad running on alpine + glibc compat. This container allows docker socket and binary pass-through.

Important notice that it's just a up-to-date nomad container, however it doesn't ship any default configuration with it. So to use it you will require to pass configuration volume - `/config` and optional data volume `/data`.

## Note that

* coreutils are required for nomad.
* libtool is required when passedthrough docker binary is used.
