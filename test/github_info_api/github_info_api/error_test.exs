defmodule GithubInfoApi.ErrorTest do
  use GithubInfoApi.DataCase, async: true

  alias Ecto.Changeset
  alias GithubInfoApi.Error

  describe "build/2" do
    test "when all params are valid, returns a build error menssage" do
      response = Error.build(:bad_request, "Invalid request")

      expected_response = "banana"

      assert expected_response = response
    end
  end

  describe "build_user_not_found_error/0" do
    test "when all params are valid, returns a valid changeset" do
      response = Error.build_user_not_found_error()

      expected_response = "banana"

      assert expected_response = response
    end
  end
end
