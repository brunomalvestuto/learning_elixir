defmodule ApplyTax do
  def to(orders, tax_rates) do
    for order = [ _, ship_to: state, net_amount: net ] <- orders,
    do: [ { :total_amount, net * (Keyword.get(tax_rates, state, 0) + 1) } | order  ]
  end
end
