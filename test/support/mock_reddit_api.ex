defmodule Asker.MockRedditAPI do
  import Tesla.Mock

  @ask_reddit_url "https://reddit.com/r/askreddit/hot.json"

  def mock_with_posts(posts) do
    mock(fn
      %{method: :get, url: @ask_reddit_url} ->
        {:ok, build_reddit_response(posts)}
    end)
  end

  defp build_reddit_response(posts) do
    json(%{
      data: %{
        children:
          Enum.map(posts, fn post ->
            %{
              kind: "Listing",
              data: post,
              after: nil,
              before: nil
            }
          end)
      }
    })
  end
end
