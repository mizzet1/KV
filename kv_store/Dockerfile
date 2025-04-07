    FROM elixir:1.15-alpine AS build

    RUN apk add --no-cache build-base npm git nodejs
    
    ENV MIX_ENV=prod
    
    WORKDIR /app
    
    RUN mix local.hex --force && \
        mix local.rebar --force
    
    COPY mix.exs mix.lock ./
    COPY config config/
    COPY lib lib/
 
    RUN mix deps.get --only prod
    RUN mix deps.compile
    RUN mix release
    
    FROM alpine:3.18 AS app
    
    RUN apk add --no-cache libstdc++ openssl ncurses-libs
    
    WORKDIR /app
    
    COPY --from=build /app/_build/prod/rel/kv_store ./
    
    ENV PHX_SERVER=true \
        MIX_ENV=prod \
        PORT=4000 \
        SECRET_KEY_BASE=pippo
    
    EXPOSE 4000
    
    CMD ["bin/kv_store", "start"]
    