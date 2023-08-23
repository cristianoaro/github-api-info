defmodule GithubInfoApi.Repo do
  use Ecto.Repo,
    otp_app: :github_info_api,
    adapter: Ecto.Adapters.Postgres
end
