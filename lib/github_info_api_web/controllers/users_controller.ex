defmodule GithubInfoApiWeb.UserController do
  use GithubInfoApiWeb, :controller

  alias GithubInfoApi.User
  alias GithubInfoApiWeb.Auth.Guardian
  alias GithubInfoApiWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- GithubInfoApi.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", token: token, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- GithubInfoApi.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- GithubInfoApi.update_user(params) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- GithubInfoApi.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end
end
