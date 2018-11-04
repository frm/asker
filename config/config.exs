use Mix.Config

config :asker,
  ecto_repos: [Asker.Repo]

config :tesla, adapter: Tesla.Adapter.Hackney

import_config "#{Mix.env()}.exs"
