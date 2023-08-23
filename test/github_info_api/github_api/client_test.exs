defmodule GithubInfoApi.GithubApi.ClientTest do
  use ExUnit.Case, async: true

  alias Plug.Conn
  alias GithubInfoApi.Error
  alias GithubInfoApi.GithubApi.Client

  describe "get_github_info/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is a valid github_userid, returns the repos info", %{bypass: bypass} do
      github_userid = "cristianoaro"

      url = endpoint_url(bypass.port)

      body = ~s([])

      Bypass.expect(bypass, "GET", "#{github_userid}/repos", fn conn ->
        conn
        |> Conn.put_req_header("user-agent", "Tesla")
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_github_info(url, github_userid)

      expected_response =
        {:ok, []}

      assert response == expected_response
    end

    test "when the github_userid is invalid, returns an error", %{bypass: bypass} do
      github_userid = "cristianoaroo"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{github_userid}/repos", fn conn ->
        Conn.resp(conn, 404, "")
      end)

      response = Client.get_github_info(url, github_userid)

      expected_response = {:error, %Error{result: "Not Found user!", status: :bad_request}}

      assert response == expected_response
    end

    test "when there is a generic error, returns an error", %{bypass: bypass} do
      github_userid = "cristianoaro"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_github_info(url, github_userid)

      expected_response = {:error, %Error{result: :econnrefused, status: :bad_request}}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}"
  end
end
