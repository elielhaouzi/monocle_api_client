defmodule MonocleApiClient.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link(opts) when is_list(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_) do
    children = [
      AntlHttpClient.insecure_finch_child_spec(MonocleApiClientFinch)
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
