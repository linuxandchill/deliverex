defmodule PackageTrack.PostalCode.DataParserTest do
  use ExUnit.Case
  alias PackageTrack.PostalCode.DataParser
  doctest PackageTrack

  test "parse_data" do
    geolocation_data = DataParser.parse_data()

    {latitude, longitude} = Map.get(geolocation_data, "00601")

    assert is_float(latitude)
    assert is_float(longitude)
  end
end
