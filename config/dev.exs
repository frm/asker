use Mix.Config

config :asker, :slack,
  oauth_token: {:system, "SLACK_BOT_OAUTH_TOKEN"},
  channel: "sandbox_1",
  threshold: 15_000

config :asker, Asker.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "asker_dev",
  hostname: "localhost",
  pool_size: 10
