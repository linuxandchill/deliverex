defmodule PackageTrack.PostalCode.CacheTest do
    use ExUnit.Case
    alias PackageTrack.PostalCode.Cache
    doctest PackageTrack

    test "get_and_set_distance" do
        p1 = "12345"
        p2 = "98745"
        distance = 99.76

        Cache.set_distance(p1, p2, distance)

        retrieved_distance = Cache.get_distance(p1, p2)

        assert distance == retrieved_distance
    end
end