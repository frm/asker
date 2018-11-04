defmodule Asker.DummyServer do
  @moduledoc """
  We need this to deploy to Heroku, since it kills any apps that don't bind to
  a port after 60s.
  """

  use Plug.Router

  import Asker.Config, only: [config!: 2]

  plug :match
  plug :dispatch

  get "/status", do: conn |> send_resp(200, "")

  match(_, do: conn |> send_resp(404, ""))

  def child_spec(opts) do
    port = port_config()

    Plug.Adapters.Cowboy.child_spec(:http, __MODULE__, opts, port: port)
  end

  defp port_config do
    case config!(__MODULE__, :port) do
      port when is_binary(port) -> String.to_integer(port)
      port when is_integer(port) -> port
      _ -> {:error, :invalid_port}
    end
  end
end
