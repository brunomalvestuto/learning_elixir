defmodule Noaa.Fetcher do
  @url "http://w1.weather.gov/xml/current_obs/KDTO.xml"

  def fetch do
    HTTPoison.get(@url) |> handle_response
  end

  def handle_response({:ok, %{body: body} }) do
    body |> to_charlist |>
    :xmerl_scan.string
  end

  def handle_response({:error, %{status_code: _, body: body}}), do: body
end
