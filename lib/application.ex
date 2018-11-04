defmodule Asker.Application do
  @moduledoc false
  @env Mix.env()

  use Application

  import Asker.Config, only: [config!: 2]

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Asker.Supervisor]

    Supervisor.start_link(children(@env), opts)
  end

  defp children(:test), do: base_children()

  defp children(_) do
    token = config!(:slack, :oauth_token)

    [
      Asker.Scheduler,
      %{
        id: Slack.Bot,
        start:
          {Slack.Bot, :start_link,
           [Asker.Slack, [], token, %{name: Asker.Slack}]}
      }
    ] ++ base_children()
  end

  defp base_children, do: [Asker.Repo]
end
