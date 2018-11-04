defmodule Asker.Services.ExtractUsers do
  use Task

  alias Asker.Accounts

  def start(users) do
    Task.start(__MODULE__, :perform, [users])
  end

  def perform(users) do
    for {id, user} <- users do
      Accounts.create_user(%{username: user[:name], slack_id: id})
    end

    :ok
  end
end
