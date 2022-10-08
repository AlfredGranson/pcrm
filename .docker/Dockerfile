FROM elixir:alpine

WORKDIR /app

EXPOSE 4000

RUN apk update
RUN apk --no-cache --update add nodejs nodejs-dev npm inotify-tools wget curl
RUN apk add build-base
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install hex phx_new --force
RUN npm install npm -g

CMD mix deps.get & npm install --prefix assets && mix ecto.create && mix ecto.migrate && mix phx.server
