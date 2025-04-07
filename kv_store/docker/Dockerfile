FROM hexpm/elixir:1.15.0-erlang-26.0-alpine-3.18.0 AS build

RUN apk add --no-cache build-base npm git

ENV MIX_ENV=prod

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only prod
RUN mix deps.compile

COPY lib lib
COPY rel rel
RUN mix release

FROM alpine:3.18 AS app

RUN apk add --no-cache libstdc++ openssl ncurses-libs

WORKDIR /app
COPY --from=build /app/_build/prod/rel/kv_store ./

ENV PHX_SERVER=true \
    MIX_ENV=prod \
    PORT=4000

CMD ["bin/kv_store", "start"]
