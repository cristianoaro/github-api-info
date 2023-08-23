defmodule GithubInfoApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :github_info_api

  alias GithubInfoApiWeb.Plugs.RefreshToken

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
  plug RefreshToken
end
