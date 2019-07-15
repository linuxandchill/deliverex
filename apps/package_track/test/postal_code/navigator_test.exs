defmodule PackageTrack.PostalCode.NavigatorTest do
  use ExUnit.Case
  alias PackageTrack.PostalCode.Navigator
  doctest PackageTrack

  describe "get_distance" do
    test "postal code strings" do
      distance = Navigator.get_distance("00601", "00610")
      assert is_float(distance)
    end

    test "postal code integers" do
      distance = Navigator.get_distance(00601, 00610)
      assert is_float(distance)
    end

    test "postal code mixed" do
      distance = Navigator.get_distance(00601, "00610")
      assert is_float(distance)
    end

    @tag :capture_log
    test "postal code unexpected format" do
      navigator_pid = Process.whereis(:postal_code_navigator)
      reference = Process.monitor(navigator_pid)

      catch_exit do
        Navigator.get_distance(6969.4982, "00610")
      end

      ## chcking that reference process that monitors navigator process received DOWN msg in its mailbox
      assert_received({:DOWN, ^reference, :process, ^navigator_pid, {%ArgumentError{}, _}})
    end
  end
end
