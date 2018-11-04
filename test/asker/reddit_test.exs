defmodule Asker.RedditTest do
  use ExUnit.Case, async: true
  doctest Asker.Config

  alias Asker.{
    MockRedditAPI,
    Reddit,
    Reddit.Post
  }

  import Asker.Factory

  describe "ask_reddit_frontpage/0" do
    test "correctly formats the posts" do
      post = params_for(:ask_reddit_post)
      MockRedditAPI.mock_with_posts([post])

      {:ok, posts} = Reddit.ask_reddit_frontpage()

      assert [
               %Post{
                 content: post.selftext,
                 id: post.id,
                 score: post.score,
                 title: post.title,
                 type: "self",
                 url: post.url
               }
             ] == posts
    end

    test "ignores meta and video posts" do
      meta_post = params_for(:ask_reddit_post, is_meta: true)
      video_post = params_for(:ask_reddit_post, is_video: true)
      MockRedditAPI.mock_with_posts([meta_post, video_post])

      assert {:ok, []} = Reddit.ask_reddit_frontpage()
    end

    test "ignores non-self posts" do
      self_post = params_for(:ask_reddit_post, is_self: true)
      non_self_post = params_for(:ask_reddit_post, is_self: false)
      MockRedditAPI.mock_with_posts([self_post, non_self_post])

      assert {:ok, [post]} = Reddit.ask_reddit_frontpage()
      assert post.id == self_post.id
    end

    test "ignores posts with the score hidden" do
      post = params_for(:ask_reddit_post, hide_score: true)
      MockRedditAPI.mock_with_posts([post])

      assert {:ok, []} = Reddit.ask_reddit_frontpage()
    end
  end
end
