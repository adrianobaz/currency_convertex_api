defmodule CurrencyConvertexApiWeb.RequestExchange do
  @spec __struct__ :: %CurrencyConvertexApiWeb.RequestExchange{
          destiny_currencys: nil,
          id: nil,
          origin_currency: nil,
          origin_value: nil,
          user_id: nil
        }
  @doc """

    params = %{ destiny_currencys: ["USD", "BRL", "JPY"], origin_currency: "EUR", origin_value: 38.89, user_id: 2 }

  """
  use Ecto.Schema
  import Ecto.Changeset

  @validators_param_array_strings %{
    destiny_currencys: [type: {:array, :string}, each: [length: [min: 3 ,max: 3], format: ~r/^[[:upper:]]+$/ ]]
  }

  embedded_schema do
    field :user_id, :integer
    field :origin_currency, :string
    field :origin_value, :decimal
    field :destiny_currencys, {:array, :string}
  end

  defp changeset(%{} = attrs) do
    %__MODULE__{}
    |> cast(attrs, [:user_id, :origin_currency, :origin_value, :destiny_currencys])
    |> validate_required([:user_id, :origin_currency, :origin_value, :destiny_currencys])
    |> validate_number(:user_id, greater_than: 0)
    |> validate_length(:origin_currency, is: 3)
    |> validate_format(:origin_currency, ~r/^[[:alpha:]]+$/)
    |> update_change(:origin_currency, &String.upcase/1)
    |> validate_number(:origin_value, greater_than: 0)
    |> validate_length(:destiny_currencys, min: 1, max: 4)
  end

  def validate_params(%{} = params) do
    case changeset(params) do
      %Ecto.Changeset{valid?: false} = changeset ->
        {:error, changeset}

      %Ecto.Changeset{valid?: true, changes: changes} ->
        {:ok, changes}
    end
  end

  def validate_format_destiny_currencys(%{} = changes) do
    case Tarams.cast(changes, @validators_param_array_strings) do
      {:ok, _result} -> :ok
      {:error, %{destiny_currencys: _errors}} = result -> result
    end
  end
end
