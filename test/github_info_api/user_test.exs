defmodule GithubInfoApi.UserTest do
  use GithubInfoApi.DataCase, async: true

  alias Ecto.Changeset
  alias GithubInfoApi.User

  import GithubInfoApi.Factory

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{password: "123456", password_hash: _}, valid?: true} = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:user_params)

      changeset = User.changeset(params)

      update_params = %{name: "Teste 02", password: "123456"}

      response = User.changeset(changeset, update_params)

      assert %Changeset{changes: %{password: "123456", password_hash: _}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset - miss param [password field blank] (validation_required)" do
      params = :user_params |> build() |> Map.delete("password")

      response = User.changeset(params)

      expected_response = %{password: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end

    test "when there are some error, returns an invalid changeset - password length less 6" do
      params =
        build(
          :user_params,
          %{
            "password" => "12345"
          }
        )

      response = User.changeset(params)

      expected_response = %{
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
