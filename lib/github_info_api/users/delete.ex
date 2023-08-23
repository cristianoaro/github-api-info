defmodule GithubInfoApi.Users.Delete do
  alias GithubInfoApi.Error
  alias GithubInfoApi.Repo
  alias GithubInfoApi.User

  def call(id) do
    case Repo.get(User, id) do
      nil -> Error.build_user_not_found_error()
      user -> Repo.delete(user)
    end
  end
end
