defmodule CurrencyConvertexApi.Error do
  alias Ecto.Changeset

  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  @moduledoc false

  @doc """
  Build error messages
  """

  @spec build(atom() | String.t(), String.t() | Changeset.t() | map()) ::
          Struct.t(
            result: String.t() | Changeset.t() | map(),
            status: atom() | String.t()
          )
  def build(status, result) do
    %__MODULE__{
      result: result,
      status: status
    }
  end
end
