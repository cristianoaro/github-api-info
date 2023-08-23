defmodule GithubInfoApi.Infos.Get do
  alias GithubInfoApi.Error

  def by_id(id) do
    with {:ok, body} <- client().get_github_info(id) do
      {:ok, body}
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> Error.build(:bad_request, result)
    end
  end

  defp client do
    :github_info_api
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:github_adapter)
  end
end
