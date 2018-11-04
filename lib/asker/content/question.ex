defmodule Asker.Content.Question do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:reddit_id, :url, :title]

  schema "questions" do
    field :reddit_id, :string
    field :url, :string
    field :title, :string

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:reddit_id)
  end
end
