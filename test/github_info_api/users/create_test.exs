defmodule GithubInfoApi.Users.CreateTest do
  use GithubInfoApi.DataCase, async: true

  alias GithubInfoApi.Error
  alias GithubInfoApi.User
  alias GithubInfoApi.Users.Create

  import Mox
  import GithubInfoApi.Factory

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

      response = Create.call(params)

      assert {:ok, %User{id: _id, password: "123456"}} = response
    end

    test "when there are invalid params, returns an error" do
      params = build(:user_params, %{"password" => "12345"})

      response = Create.call(params)
      {:error, %Error{status: status, result: changeset}} = response

      expected_response = %{password: ["should be at least 6 character(s)"]}

      assert :bad_request == status
      assert errors_on(changeset) == expected_response
    end
  end
end
