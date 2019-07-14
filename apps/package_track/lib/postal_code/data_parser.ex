defmodule PackageTrack.PostalCode.DataParser do
  @moduledoc """
  Loads data from census document and parses it 
  """
  @postal_codes_filepath "data/2017_Gaz_zcta_national.txt"

  NimbleCSV.define(CSVParser, separator: "\t", escape: "\"")

  def parse_data do
    # File.stream! @postal_codes_filepath |> String.split("\n")
    @postal_codes_filepath
    |> File.stream!()
    |> CSVParser.parse_stream()
    |> Stream.filter(&data_row?(&1))
    |> Stream.map(&parse_columns(&1))
    |> Stream.map(&format_row(&1))
    |> Enum.into(%{})
  end

  defp data_row?(row) do
    # only get rows that have all columns
    case row do
      [_postal_code, _, _, _, _, _latitude, _longitude] -> true
      _ -> false
    end
  end

  def parse_columns(row) do
    ## Only get the columns we need from each row
    [postal_code, _, _, _, _, latitude, longitude] = row
    [postal_code, latitude, longitude]
  end

  defp parse_number(str) do
    str |> String.replace(" ", "") |> String.to_float()
  end

  defp format_row([postal_code, latitude, longitude]) do
      latitude = parse_number(latitude)
      longitude = parse_number(longitude)
      {postal_code, {latitude, longitude}}
  end
end
