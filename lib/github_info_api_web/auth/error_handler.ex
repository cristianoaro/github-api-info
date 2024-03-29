defmodule GithubInfoApiWeb.Auth.ErrorHandler do
  import Plug.Conn

  alias Guardian.Plug.ErrorHandler

  @behaviour ErrorHandler

  @impl ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(type)})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
  end
end
