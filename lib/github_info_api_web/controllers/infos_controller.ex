defmodule GithubInfoApiWeb.InfoController do
  use GithubInfoApiWeb, :controller

  alias GithubInfoApi.Info
  alias GithubInfoApiWeb.FallbackController

  action_fallback FallbackController

  def show(conn, %{"id" => id}) do
    with {:ok, info} <- GithubInfoApi.get_info_by_userid(id) do
      conn
      |> put_status(:ok)
      |> render("info.json", info: info)
    end
  end
end
