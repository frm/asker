use Mix.Config

config :asker,
  ecto_repos: [Asker.Repo]

config :asker, Asker.DummyServer, port: 4000

config :tesla, adapter: Tesla.Adapter.Hackney

import_config "#{Mix.env()}.exs"
