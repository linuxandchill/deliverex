defmodule PackageTrack.PostalCode.Supervisor do
  use Supervisor
  alias PackageTrack.PostalCode.{Store, Navigator, Cache}

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      # will start GenServer Store process for us
      worker(Store, []),
      worker(Navigator, []),
      worker(Cache, []),
    ]

    supervise(children, strategy: :one_for_one)
  end
end
