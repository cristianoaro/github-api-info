defmodule GithubInfoApi.GithubApi.Client do
  use Tesla

  alias GithubInfoApi.Error
  alias GithubInfoApi.GithubApi.Behavior
  alias Tesla.Env

  @behaviour Behavior

  @base_url "https://api.github.com/users"

  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]

  def get_github_info(url \\ @base_url, github_user) do
    "#{url}/#{github_user}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    body_processed = handle_body(body)

    {:ok, body_processed}
  end

  defp handle_get({:ok, %Env{status: 404, body: _body}}) do
    Error.build(:bad_request, "Not Found user!")
  end

  defp handle_get({:error, reason}) do
    Error.build(:bad_request, reason)
  end

  defp handle_body(body) do
    Enum.map(body, fn repo ->
      %{
        id: repo["id"],
        name: repo["name"],
        description: repo["description"],
        html_url: repo["html_url"],
        stargazers_count: repo["stargazers_count"]
      }
    end)
  end
end
