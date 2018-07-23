FROM elixir:1.6.6

RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new-1.3.3.ez
RUN mkdir /app

WORKDIR /app

COPY mix.exs /app/mix.exs
COPY mix.lock /app/mix.lock

RUN mix local.hex --force && mix local.rebar --force && mix deps.get && mix deps.compile

COPY . /app

EXPOSE 4000

CMD mix phx.server
