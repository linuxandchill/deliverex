defmodule PackageTrack.PostalCode.NavigatorTest do
    use ExUnit.Case
    alias PackageTrack.PostalCode.Navigator
    doctest PackageTrack

    describe "get_distance" do
        test "basic test" do
            distance = Navigator.get_distance("00601", "00610")

            assert distance == 45.98
        end
    end
end