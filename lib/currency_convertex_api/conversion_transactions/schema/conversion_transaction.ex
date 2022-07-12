defmodule CurrencyConvertexApi.Schema.ConversionTransaction do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @spec __struct__ :: %CurrencyConvertexApi.Schema.ConversionTransaction{
          __meta__: Ecto.Schema.Metadata.t(),
          conversion_rate: nil,
          created_at: nil,
          destiny_currency: nil,
          id: nil,
          origin_currency: nil,
          origin_value: nil,
          user_id: nil
        }
  @doc """
    %CurrencyConvertexApi.Schema.ConversionTransaction{
      user_id: 2,
      origin_currency: "EUR",
      origin_value: 38.89,
      destiny_currency: "USD",
      conversion_rate: 1.056,
      created_at: ~U[2022-06-16 03:29:03Z]
    }
  """

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

  schema "conversion_transactions" do
    field :user_id, :integer
    field :origin_currency, :string
    field :origin_value, :decimal
    field :destiny_currency, :string
    field :conversion_rate, :decimal
    field :created_at, :utc_datetime
  end

  def changeset(struct \\ %__MODULE__{}, %{} = params, fields \\ @required_fields) do
    struct
    |> cast(params, @fields_that_can_be_changed)
    |> validate_required(fields)
    |> validate_number(:user_id, greater_than: 0)
    |> validate_length(:origin_currency, is: 3)
    |> validate_length(:destiny_currency, is: 3)
    |> validate_number(:conversion_rate, greater_than: 0)
    |> validate_number(:origin_value, greater_than: 0)
  end
end
