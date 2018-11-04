defmodule Asker.Content do
  import Ecto.Query, warn: false

  alias Asker.Content.Question
  alias Asker.Repo

  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  def get_question(params) do
    Repo.get_by(Question, params)
  end
end
