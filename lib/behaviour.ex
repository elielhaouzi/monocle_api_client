defmodule MonocleApiClient.Behaviour do
  @moduledoc false

  # @callback login(binary, binary, binary) :: {:ok, binary} | {:error, binary}
  # @callback create_user(binary, map) :: {:ok, User.t()} | {:error, binary | Ecto.Changeset.t()}
end
