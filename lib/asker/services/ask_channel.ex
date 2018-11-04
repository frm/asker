defmodule Asker.Services.AskChannel do
  alias Asker.Content
  alias Asker.Reddit
  alias Asker.Reddit.Post

  import Asker.Config, only: [config!: 2]

  def perform do
    channel = config!(:slack, :channel)
    threshold = config!(:slack, :threshold)

    with {:ok, questions} <- get_ask_reddit_questions(threshold) do
      questions
      |> Stream.filter(&new_question?/1)
      |> Stream.map(&save_question/1)
      |> Stream.reject(&is_nil/1)
      |> Enum.map(&send_to_slack(&1, channel))
    else
      error ->
        error
    end
  end

  defp get_ask_reddit_questions(threshold) do
    case Reddit.ask_reddit_frontpage() do
      {:ok, questions} ->
        {:ok, Enum.filter(questions, &(&1.score >= threshold))}

      error ->
        error
    end
  end

  defp new_question?(%Post{} = post) do
    is_nil(Content.get_question(reddit_id: post.id))
  end

  defp save_question(%Post{} = post) do
    Content.create_question(%{
      reddit_id: post.id,
      title: post.title,
      url: post.url
    })
    |> case do
      {:ok, question} -> question
      _ -> nil
    end
  end

  defp send_to_slack(post, channel) do
    message = post.title
    formatted_channel = format_channel(channel)

    send Asker.Slack, {:message, message, formatted_channel}
  end

  defp format_channel("#" <> _channel_name = channel), do: channel
  defp format_channel(channel_name), do: "##{channel_name}"
end
