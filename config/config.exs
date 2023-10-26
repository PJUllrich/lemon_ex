import Config

if Mix.env() in [:dev, :test] do
  config :lemon_ex,
    api_key: System.get_env("LEMONSQUEEZY_API_KEY", "foobar"),
    webhook_secret: System.get_env("LEMONSQUEEZY_WEBHOOK_SECRET", "barfoo"),
    request_options: [recv_timeout: 5000]
end
