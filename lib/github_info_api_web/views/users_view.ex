defmodule GithubInfoApiWeb.UserView do
  use GithubInfoApiWeb, :view

  alias GithubInfoApi.User

  def render("create.json", %{user: %User{} = user, token: token}) do
    %{
      message: "User created",
      user: user,
      token: token
    }
  end

  def render("user.json", %{user: %User{} = user}) do
    %{
      user: user
    }
  end

  def render("sign_in.json", %{token: token}) do
    %{
      token: token
    }
  end
end
