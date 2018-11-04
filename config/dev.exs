use Mix.Config

config :asker, :slack,
  oauth_token: {:system, "SLACK_BOT_OAUTH_TOKEN"},
  channel: {:system, "SLACK_CHANNEL"},
  threshold: {:system, "SLACK_THRESHOLD"}

config :asker, Asker.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "asker_dev",
  hostname: "localhost",
  pool_size: 10
