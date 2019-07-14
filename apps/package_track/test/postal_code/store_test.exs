defmodule PackageTrack.PostalCode.SupervisorTest do
  use ExUnit.Case
  alias PackageTrack.PostalCode.Store

  test "get_geolocation" do
    {latitude, longitude} = Store.get_geolocation("00601")

    assert is_float(latitude)
    assert is_float(longitude)
  end
end
