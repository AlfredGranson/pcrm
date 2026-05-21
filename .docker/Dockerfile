FROM elixir:1.18.4-alpine

WORKDIR /app

EXPOSE 4000

RUN apk update && \
    apk --no-cache add nodejs npm inotify-tools build-base curl

RUN mix local.hex --force && \
    mix local.rebar --force

CMD mix deps.get && \
    npm install --prefix assets && \
    mix assets.setup && \
    mix ecto.create && \
    mix ecto.migrate && \
    mix phx.server
