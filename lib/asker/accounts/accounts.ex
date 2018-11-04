defmodule Asker.Accounts do
  import Ecto.Query, warn: false

  alias Asker.Accounts.User
  alias Asker.Repo

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
