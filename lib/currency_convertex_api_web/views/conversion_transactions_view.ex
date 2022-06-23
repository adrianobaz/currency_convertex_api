defmodule CurrencyConvertexApiWeb.ConversionTransactionsView do
  use CurrencyConvertexApiWeb, :view

  def render("create.json", %{result: list_result}) do
    list_result
  end

end
