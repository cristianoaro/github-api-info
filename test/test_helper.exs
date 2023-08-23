ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(GithubInfoApi.Repo, :manual)

Mox.defmock(GithubInfoApi.GithubApi.ClientMock, for: GithubInfoApi.GithubApi.Behavior)
