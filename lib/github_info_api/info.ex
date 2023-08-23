defmodule GithubInfoApi.Info do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: true}

  @required_params [:id, :name, :description, :html_url, :stargazers_count]

  @derive {Jason.Encoder, only: @required_params}

  schema "infos" do
    field :password, :string, virtual: true
    field :password_hash, :string

    field :id, :integer
    field :name, :string
    field :description, :string
    field :html_url, :string
    field :stargazers_count, :integer

    timestamps()
  end

  def build(params) do
    params
    |> apply_action(:insert)
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
