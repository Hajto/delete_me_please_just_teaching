import Config

if config_env() in [:prod, :dev] do
  config :ticker, Ticker, job: HTTPJob
else
  config :ticker, Ticker, job: TickerTest.Stub
end
