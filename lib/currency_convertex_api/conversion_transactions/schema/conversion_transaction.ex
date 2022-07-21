defmodule CurrencyConvertexApi.ConversionTransaction do
  use Ecto.Schema
  import Ecto.Changeset
  alias CurrencyConvertexApi.User

  @fields_that_can_be_changed [
    :user_id,
    :origin_currency,
    :origin_value,
    :destiny_currency,
    :conversion_rate,
    :created_at
  ]

  @required_fields [
    :user_id,
    :origin_currency,
    :origin_value,
    :destiny_currency,
    :conversion_rate,
    :created_at
  ]

  @derive {Jason.Encoder, only: @required_fields ++ [:id]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "conversion_transactions" do
    field :origin_currency, :string
    field :origin_value, :decimal
    field :destiny_currency, :string
    field :conversion_rate, :decimal
    field :created_at, :utc_datetime

    belongs_to :user, User
  end

  def build(changeset), do: apply_action(changeset, :insert)

  def changeset(struct \\ %__MODULE__{}, %{} = params, fields \\ @required_fields) do
    struct
    |> cast(params, @fields_that_can_be_changed)
    |> validate_required(fields)
    |> validate_length(:origin_currency, is: 3)
    |> validate_length(:destiny_currency, is: 3)
    |> validate_number(:conversion_rate, greater_than: 0)
    |> validate_number(:origin_value, greater_than: 0)
  end
end
