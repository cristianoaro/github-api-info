defmodule GithubInfoApi.Error do
  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  def build(status, result) do
    {:error,
     %__MODULE__{
       status: status,
       result: result
     }}
  end

  def build_user_not_found_error, do: build(:not_found, "User not found")
end
