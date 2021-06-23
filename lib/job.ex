defmodule Job do
  @callback fetch(url :: String.t()) ::
              {:ok, data :: any()}
              | {:error, reason :: atom()}
end
