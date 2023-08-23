defmodule GithubInfoApiWeb.Router do
  use GithubInfoApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug GithubInfoApiWeb.Auth.Pipeline
  end

  scope "/api", GithubInfoApiWeb do
    pipe_through [:api, :auth]

    resources "/info", InfoController, only: [:show]

    resources "/users", UserController, except: [:new, :edit, :create]
  end

  scope "/api", GithubInfoApiWeb do
    pipe_through :api

    post "/users", UserController, :create

    post "/users/login", UserController, :sign_in
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:github_info_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: GithubInfoApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
