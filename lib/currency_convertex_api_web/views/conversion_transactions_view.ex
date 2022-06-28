defmodule CurrencyConvertexApiWeb.ConversionTransactionsView do
  use CurrencyConvertexApiWeb, :view

  def render("create.json", %{result: result}), do: result

  def render("show.json", %{result: result}), do: result
end
