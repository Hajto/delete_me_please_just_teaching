defmodule HTTPJob do
  @behaviour Job

  @impl true
  def fetch(url) do
    url
    |> HTTPoison.get()
    |> process_result()
  end

  defp process_result({:ok, %HTTPoison.Response{status_code: 301, headers: headers}}) do
    {_header, location} = List.keyfind(headers, "Location", 0)
    fetch(location)
  end

  defp process_result(result), do: result
end
