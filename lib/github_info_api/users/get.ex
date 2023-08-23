defmodule GithubInfoApi.Users.Get do
  alias GithubInfoApi.Error
  alias GithubInfoApi.Repo
  alias GithubInfoApi.User

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> Error.build_user_not_found_error()
      user -> {:ok, user}
    end
  end
end
