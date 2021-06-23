defmodule Ticker do
  use GenServer

  @job Application.compile_env(:ticker, [Ticker, :job])

  def start_link(interval, url) do
    GenServer.start_link(__MODULE__, {interval, url})
  end

  @impl GenServer
  def init({interval, url}) do
    state = %{
      interval: interval,
      url: url
    }

    :timer.send_interval(interval, self(), :kaleta)
    {:ok, state}
  end

  @impl GenServer
  def handle_info(:kaleta, %{url: url} = state) do
    with {:ok, body} <- @job.fetch(url) do
      IO.inspect(body)
    end

    {:noreply, state}
  end
end
