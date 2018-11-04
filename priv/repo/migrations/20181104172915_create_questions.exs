defmodule Asker.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :reddit_id, :string, null: false
      add :url, :string, null: false
      add :title, :string, null: false

      timestamps()
    end

    create unique_index(:questions, :reddit_id)
  end
end
