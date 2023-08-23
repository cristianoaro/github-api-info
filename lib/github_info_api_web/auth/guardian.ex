defmodule GithubInfoApiWeb.Auth.Guardian do
  use Guardian, otp_app: :github_info_api

  alias GithubInfoApi.Error
  alias GithubInfoApi.User
  alias GithubInfoApi.Users.Get, as: UserGet

  def subject_for_token(%User{id: id}, _claims) do
    {:ok, id}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> UserGet.by_id()
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- UserGet.by_id(user_id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user, %{}, token_type: "refresh") do
      {:ok, token}
    else
      false -> Error.build(:unauthorized, "Please verify your credentials")
      error -> error
    end
  end

  def authenticate(_) do
    Error.build(:bad_request, "Invalid or missing params")
  end
end
