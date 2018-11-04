use Mix.Config

config :asker, Asker.Scheduler,
  jobs: [
    ask_jarvas: [
      schedule: {:extended, "*/30"},
      task: {Asker.Services.AskChannel, :perform, []}
    ]
  ]

config :asker, :slack,
  oauth_token: {:system, "SLACK_BOT_OAUTH_TOKEN"},
  channel: {:system, "SLACK_CHANNEL"},
  threshold: {:system, "SLACK_THRESHOLD"}

config :logger, level: :info

config :asker, Asker.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true
