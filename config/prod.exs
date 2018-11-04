use Mix.Config

config :asker, Asker.Scheduler,
  jobs: [
    {"0 * * * *", {Asker.Services.AskChannel, :perform, []}}
  ]
