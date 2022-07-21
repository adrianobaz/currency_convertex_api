defmodule CurrencyConvertexApiWeb.RequestExchange do
  @typedoc """

    params = %{ destiny_currencys: ["USD", "BRL", "JPY"], origin_currency: "EUR", origin_value: 38.89, user_id: "dc1ec004-ebab-4ca3-acfa-0e996ac9db75" }

  """

  @moduledoc false

  @type t :: %__MODULE__{
          destiny_currencys: list(String.t()),
          origin_currency: String.t(),
          origin_value: Decimal.t(),
          user_id: binary()
        }

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  @required_fields [:user_id, :origin_value, :destiny_currencys]

  @fields_that_can_be_changed [:user_id, :origin_currency, :origin_value, :destiny_currencys]

  @validators_param_array_strings %{
    destiny_currencys: [
      type: {:array, :string},
      each: [length: [min: 3, max: 3], format: ~r/^[[:upper:]]+$/]
    ]
  }

  embedded_schema do
    field :user_id, :string
    field :origin_currency, :string
    field :origin_value, :decimal
    field :destiny_currencys, {:array, :string}
  end

  defp changeset(struct \\ %__MODULE__{}, %{} = params, fields \\ @required_fields) do
    struct
    |> cast(params, @fields_that_can_be_changed)
    |> validate_required(fields)
    |> validate_length(:origin_currency, is: 3)
    |> validate_format(:origin_currency, ~r/^[[:alpha:]]+$/)
    |> update_change(:origin_currency, &String.upcase/1)
    |> validate_number(:origin_value, greater_than: 0)
    |> validate_length(:destiny_currencys, min: 1, max: 4)
  end

  @spec validate_params(%{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          {:error, Ecto.Changeset.t()} | {:ok, %{optional(atom) => any}}
  def validate_params(%{} = params) do
    case changeset(params) do
      %Ecto.Changeset{valid?: false} = changeset ->
        {:error, changeset}

      %Ecto.Changeset{valid?: true, changes: changes} ->
        {:ok, changes}
    end
  end

  @spec validate_format_destiny_currencys(map) ::
          :ok | {:error, %{:destiny_currencys => any, optional(any) => any}}
  def validate_format_destiny_currencys(%{} = changes) do
    case Tarams.cast(changes, @validators_param_array_strings) do
      {:ok, _result} -> :ok
      {:error, %{destiny_currencys: _errors}} = result -> result
    end
  end
end
