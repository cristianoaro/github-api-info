defmodule GithubInfoApi.GithubApi.Behavior do
  alias GithubInfoApi.Error

  @callback get_github_info(String.t()) :: {:ok, map()} | Error.t()
end
