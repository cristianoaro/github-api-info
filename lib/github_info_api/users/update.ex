defmodule GithubInfoApi.Users.Update do
  alias GithubInfoApi.Error
  alias GithubInfoApi.Repo
  alias GithubInfoApi.User

  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> Error.build_user_not_found_error()
      user -> do_update(user, params)
    end
  end

  defp do_update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
