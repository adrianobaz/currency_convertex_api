defmodule CurrencyConvertexApi.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:name, :password]

  @fields_that_can_be_changed [:name, :password]

  @primary_key {:id, :binary_id, autogenerate: true}

  @derive {Jason.Encoder, only: [:id, :name]}

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps(inserted_at: :created_at, updated_at: false, type: :utc_datetime)
  end

  @doc false
  def changeset(user \\ %__MODULE__{}, %{} = attrs, fields \\ @required_fields) do
    user
    |> cast(attrs, @fields_that_can_be_changed)
    |> validate_required(fields)
    |> validate_length(:name, min: 3, max: 255)
    |> validate_length(:password, min: 6)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
