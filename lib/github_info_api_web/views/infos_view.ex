defmodule GithubInfoApiWeb.InfoView do
  use GithubInfoApiWeb, :view

  alias GithubInfoApi.Info

  def render("info.json", %{info: info}) do
    %{
      info: info
    }
  end
end
