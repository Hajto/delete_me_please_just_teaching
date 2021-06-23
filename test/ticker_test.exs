defmodule TickerTest do
  use ExUnit.Case

  defmodule Stub do
    @behaviour Job

    @impl Job
    def fetch(url) do
      send(self(), url)
      {:ok, "keke"}
    end
  end

  test "init start interval" do
    url = "url"
    interval = 100
    assert {:ok, state} = Ticker.init({interval, url})

    assert state == %{
             interval: interval,
             url: url
           }

    assert_receive :kaleta, 2 * interval
  end

  test "handle_info calls job.fetch/1" do
    state = %{
      interval: 100,
      url: "url"
    }

    assert {:noreply, state} == Ticker.handle_info(:kaleta, state)
    assert_receive "url"
  end
end
