defmodule GithubInfoApiWeb.FallbackController do
  use GithubInfoApiWeb, :controller

  alias GithubInfoApi.Error
  alias GithubInfoApiWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}} = _error) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
