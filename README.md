# pcrm ![tests](https://github.com/AlfredGranson/pcrm/actions/workflows/elixir.yml/badge.svg)


pcrm is a devoper-conscious Phoenix-based customer relationship management system.

## Installation

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
