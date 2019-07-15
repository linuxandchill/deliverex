defmodule PackageTrack.PostalCode.Navigator do
    use GenServer
 alias PackageTrack.PostalCode.Store
  alias :math, as: Math
  @radius 3959

  ## Client
  def start_link() do
    ## Start by calling start_link and passing module with the server implementation (this module)
    ## Second argument is initiual
      GenServer.start_link(__MODULE__, [], name: :postal_code_navigator)
  end

  ## Client 
  def get_distance(from, to) do
    GenServer.call(:postal_code_navigator, {:get_distance, from, to})
  end

  ##Server
  def init(arg) do 
    {:ok, arg}
  end

  ## Server 
  def handle_call({:get_distance, from, to}, _from, state) do 
    distance = do_get_distance(from, to)
    {:reply, distance, state}
  end

  defp do_get_distance(from, to) do
    {lat1, long1} = get_geolocation(from)
    {lat2, long2} = get_geolocation(to)

    calculate_distance({lat1, long1}, {lat2, long2})
  end

  def get_geolocation(postal_code) when is_binary(postal_code) do
    Store.get_geolocation(postal_code)
  end

  def get_geolocation(postal_code) when is_integer(postal_code) do
    ## Integer.to_string removes zeros
    postal_code
    |> Integer.to_string()
    |> String.pad_leading(5, ["0"])
    |> get_geolocation
  end

  ## catch all ie u get float zip code
  def get_geolocation(postal_code) do
    error = "Bad Argument Error: `postal_code`. Received: (#{inspect(postal_code)})"
    raise ArgumentError, error
  end

  defp calculate_distance({lat1, long1}, {lat2, long2}) do
    lat_diff = degrees_to_radians(lat2 - lat1)
    long_diff = degrees_to_radians(long2 - long1)

    lat1 = degrees_to_radians(lat1)
    lat2 = degrees_to_radians(lat2)

    cos_lat1 = Math.cos(lat1)
    cos_lat2 = Math.cos(lat2)

    sin_lat_diff_sq = Math.sin(lat_diff / 2) |> Math.pow(2)
    sin_long_diff_sq = Math.sin(long_diff / 2) |> Math.pow(2)

    a = sin_lat_diff_sq + (cos_lat1 * cos_lat2 * sin_long_diff_sq)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    @radius * c |> Float.round(2)
  end

  defp degrees_to_radians(degrees) do
    degrees * (Math.pi() / 180)
  end
end
