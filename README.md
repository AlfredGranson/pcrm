# pcrm ![tests](https://github.com/AlfredGranson/pcrm/actions/workflows/elixir.yml/badge.svg) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/AlfredGranson/pcrm/blob/main/LICENSE) ![https://www.repostatus.org/#wip](https://www.repostatus.org/badges/latest/wip.svg)

pcrm is a devoper-conscious Phoenix-based customer relationship management system.

:warning: pcrm is in under development :warning:

## Installation & Setup
While pcrm can be setup locally for development, it is recommended and instructions are currently only available for use with docker/docker compose.

### Prerequisites
- [Docker](https://docs.docker.com/get-docker/)
- [Docker compose](https://docs.docker.com/compose/install/)

### Instructions
Clone and `cd` into the repository:

```
git@github.com:AlfredGranson/pcrm.git && cd pcrm
```
Run the container:

```
docker compose up
```
You can now visit the application by going to [http://localhost:4000/](http://localhost:4000/)

## Tests
Run outisde of the container in the root of the application:

```
docker compose run --rm -e MIX_ENV=test phoenix mix test
```

## Documentation
Documentation for pcrm is currently available in the [wiki](https://github.com/AlfredGranson/pcrm/wiki).
