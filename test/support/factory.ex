defmodule GithubInfoApi.Factory do
  use ExMachina.Ecto, repo: GithubInfoApi.Repo

  alias GithubInfoApi.User

  def user_params_factory do
    %{
      "password" => "123456"
    }
  end

  def user_factory do
    %User{
      id: "5b1addd2-0493-4cfd-9d61-cf662594e685"
    }
  end
end
