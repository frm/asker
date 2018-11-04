defmodule Asker.Services.AskChannelTest do
  use Asker.DataCase, async: true
  doctest Asker.Services.AskChannel

  alias Asker.{
    Content.Question,
    MockRedditAPI,
    Repo,
    Services.AskChannel
  }

  setup do
    Process.register(self(), Asker.Slack)
    Application.put_env(:asker, :slack, channel: "test", threshold: 1_000)

    :ok
  end

  describe "perform/1" do
    test "creates a question for every AskReddit post" do
      posts = for _ <- 0..3, do: params_for(:ask_reddit_post, score: 1_500)
      MockRedditAPI.mock_with_posts(posts)

      AskChannel.perform()

      assert Repo.aggregate(Question, :count, :id) == 4
    end

    test "ignores posts below the threshold" do
      posts = for _ <- 0..3, do: params_for(:ask_reddit_post, score: 500)
      MockRedditAPI.mock_with_posts(posts)

      AskChannel.perform()

      assert Repo.aggregate(Question, :count, :id) == 0
    end

    test "ignores repeated posts" do
      posts = for _ <- 0..3, do: params_for(:ask_reddit_post, score: 1_500)
      new_post = params_for(:ask_reddit_post, score: 1_500)
      MockRedditAPI.mock_with_posts(posts)

      AskChannel.perform()
      assert Repo.aggregate(Question, :count, :id) == 4

      MockRedditAPI.mock_with_posts([new_post | posts])
      AskChannel.perform()

      assert Repo.aggregate(Question, :count, :id) == 5
    end

    test "sends a slack message for every new post above the threshold" do
      %{title: title} = post = params_for(:ask_reddit_post, score: 1_500)
      MockRedditAPI.mock_with_posts([post])

      AskChannel.perform()

      assert_receive {:message, ^title, "#test"}
    end
  end
end
