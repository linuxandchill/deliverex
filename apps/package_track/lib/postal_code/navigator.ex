defmodule PackageTrack.PostalCode.Navigator do
    def get_distance(from, to) do 
        do_get_distance(from, to)
    end

    defp do_get_distance(from, to) do
        {lat1, long1} = get_geolocation(from)
        {lat2, long2} = get_geolocation(to)

        45.98
    end

    defp get_geolocation(postal_code) do
        {123, 456}
    end

    
end