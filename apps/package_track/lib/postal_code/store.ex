defmodule PackageTrack.PostalCode.Store do
  use GenServer
  require Logger
  alias PackageTrack.PostalCode.DataParser

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: :postal_code_store)
  end

  def init(_) do
    # IO.inspect init_state => %{}
    {:ok, DataParser.parse_data()}
  end

  def get_geolocation(postal_code) do
    GenServer.call(:postal_code_store, {:get_geolocation, postal_code})
  end

  ## Callbacks
  def handle_call({:get_geolocation, postal_code}, _from, geolocation_data) do
    geolocation = Map.get(geolocation_data, postal_code)
    # second arg is what caller will receive
    # third arg is new state of GenServer process
    {:reply, geolocation, geolocation_data}
  end

  defp handle_nil_geolocation(geolocation) do
    case geolocation do
      {lat, long} -> {lat, long}
      nil -> Logger.info("Information for this postal code is not available")
    end
  end
end
