defmodule MonocleApiClient do
  @moduledoc """
  Documentation for `MonocleApiClient`.
  """

  @spec list_stores(binary) :: {:ok, map()} | {:error, binary}
  def list_stores(api_key) do
    params = %{
      method: :get,
      resource: "#{base_url()}/stores",
      headers: base_headers() |> put_authorization_header(api_key),
      body: %{}
    }

    opts = [obfuscate_keys: ["authorization"]]

    request(params, opts)
  end

  defp request(%{method: method, resource: resource, headers: headers, body: body}, opts) do
    AntlHttpClient.request(
      MonocleApiClientFinch,
      "monocle_api",
      %{
        method: method,
        resource: resource,
        headers: %{} = headers,
        body: %{} = body
      },
      Keyword.merge(
        [obfuscate_keys: [], logger: logger(), receive_timeout: receive_timeout()],
        opts
      )
    )
  end

  defp base_headers() do
    %{
      "content-type" => "application/json",
      "user-agent" => "MonocleApiClient/1.0; +(https://github.com/elielhaouzi/monocle_api_client)"
    }
  end

  defp put_authorization_header(headers, api_key) when is_binary(api_key) do
    headers |> Map.put("authorization", "Basic #{Base.encode64("#{api_key}:")}"
  end

  defp base_url(), do: Application.fetch_env!(:monocle_client, :base_url)
  defp logger(), do: Application.get_env(:monocle_client, :logger, Logger)
  defp receive_timeout(), do: Application.get_env(:monocle_client, :receive_timeout, 50_000)
  defp revision(), do: Application.fetch_env!(:monocle_client, :revision)
end
