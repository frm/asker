use Mix.Config

config :asker, Asker.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DATABASE_POSTGRESQL_USERNAME") || "postgres",
  password: System.get_env("DATABASE_POSTGRESQL_PASSWORD") || "postgres",
  database: "asker_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :tesla, adapter: Tesla.Mock
