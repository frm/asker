defmodule Asker.Reddit do
  use Tesla

  alias Asker.Reddit.Post

  plug Tesla.Middleware.BaseUrl, "https://reddit.com/"
  plug Tesla.Middleware.Headers, [{"User-Agent", "Tesla"}]
  plug Tesla.Middleware.FollowRedirects, max_redirects: 1
  plug Tesla.Middleware.JSON

  def ask_reddit_frontpage do
    get("/r/askreddit/hot.json")
    |> parse_response(fn %{"children" => children} ->
      children
      |> Stream.map(& &1["data"])
      |> Stream.reject(& &1["is_meta"])
      |> Stream.reject(& &1["is_video"])
      |> Stream.reject(& &1["hide_score"])
      |> Stream.filter(& &1["is_self"])
      |> Enum.map(&to_reddit_post/1)
    end)
  end

  defp to_reddit_post(json) do
    %Post{
      content: json["selftext"],
      id: json["id"],
      score: json["score"],
      title: json["title"],
      type: "self",
      url: json["url"]
    }
  end

  defp parse_response({:ok, %{status: 200, body: %{"data" => data}}}, callback) do
    {:ok, callback.(data)}
  end

  defp parse_response({:error, error}, _) do
    {:error, error}
  end
end
