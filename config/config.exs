import Config

config :lemon_ex,
       :api_key,
       System.get_env("LEMONSQUEEZY_API_KEY") ||
         raise("Missing environment variable LEMONSQUEEZY_API_KEY.")
