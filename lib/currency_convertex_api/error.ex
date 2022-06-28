defmodule CurrencyConvertexApi.Error do
  alias Ecto.Changeset

  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  @spec build(atom() | String.t(), String.t() | Changeset.t()) ::
          Struct.t(
            result: String.t() | Changeset.t(),
            status: atom()
          )
  @doc """
  Build error messages.
  """
  def build(status, result) do
    %__MODULE__{
      result: result,
      status: status
    }
  end
end
