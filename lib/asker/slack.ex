defmodule Asker.Slack do
  use Slack

  require IEx

  def handle_connect(slack, state) do
    Asker.Services.ExtractUsers.start(slack.users)

    {:ok, state}
  end

  def handle_info({:message, message, channel}, slack, state) do
    send_message(message, channel, slack)

    {:ok, state}
  end
end
