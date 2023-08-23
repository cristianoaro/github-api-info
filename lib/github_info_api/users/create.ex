defmodule GithubInfoApi.Users.Create do
  alias GithubInfoApi.Error
  alias GithubInfoApi.Repo
  alias GithubInfoApi.User

  def call(params) do
    changeset = User.changeset(params)

    with {:ok, %User{}} <- User.build(changeset),
         {:ok, %User{} = user} <- Repo.insert(changeset) do
      {:ok, user}
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> Error.build(:bad_request, result)
    end
  end
end
