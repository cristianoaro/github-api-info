defmodule GithubInfoApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      GithubInfoApiWeb.Telemetry,
      # Start the Ecto repository
      GithubInfoApi.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: GithubInfoApi.PubSub},
      # Start Finch
      {Finch, name: GithubInfoApi.Finch},
      # Start the Endpoint (http/https)
      GithubInfoApiWeb.Endpoint
      # Start a worker by calling: GithubInfoApi.Worker.start_link(arg)
      # {GithubInfoApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GithubInfoApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GithubInfoApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
