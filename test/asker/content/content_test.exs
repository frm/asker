defmodule Asker.ContentTest do
  use Asker.DataCase, async: true
  doctest Asker.Content

  alias Asker.{
    Content,
    Content.Question,
    Repo
  }

  describe "create_question/1" do
    test "inserts a new question if the data is valid" do
      params = params_for(:question)

      Content.create_question(params)

      assert Repo.aggregate(Question, :count, :id) == 1
    end

    test "requires all fields" do
      params_without_reddit_id = params_for(:question, reddit_id: nil)
      params_without_title = params_for(:question, title: nil)
      params_without_url = params_for(:question, url: nil)

      Content.create_question(params_without_reddit_id)
      Content.create_question(params_without_title)
      Content.create_question(params_without_url)

      assert Repo.aggregate(Question, :count, :id) == 0
    end

    test "fails if the question already exists" do
      question = insert(:question)
      params = params_for(:question, reddit_id: question.reddit_id)

      Content.create_question(params)

      assert Repo.aggregate(Question, :count, :id) == 1
    end
  end

  describe "get_question/1" do
    test "returns the question if it exists" do
      question = insert(:question)

      found_question = Content.get_question(reddit_id: question.reddit_id)

      assert found_question.id == question.id
    end
  end
end
