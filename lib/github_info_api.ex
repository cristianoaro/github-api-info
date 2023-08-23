defmodule GithubInfoApi do
  alias GithubInfoApi.Infos.Get, as: InfoGet

  alias GithubInfoApi.Users.Create, as: UserCreate
  alias GithubInfoApi.Users.Delete, as: UserDelete
  alias GithubInfoApi.Users.Get, as: UserGet
  alias GithubInfoApi.Users.Update, as: UserUpdate

  # INFO
  defdelegate get_info_by_userid(user_id), to: InfoGet, as: :by_id

  # USER
  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
  defdelegate update_user(params), to: UserUpdate, as: :call
end
