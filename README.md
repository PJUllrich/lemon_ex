# LemonEx

An Elixir client for the API and Webhooks of LemonSqueezy.

## Installation

```elixir
def deps do
  [
    {:lemon_ex, "~> 0.1.0"}
  ]
end
```

[Documentation](https://hexdocs.pm/lemon_ex/readme.html)

## Configuration

To make API calls, you need to create an [API key](https://docs.lemonsqueezy.com/docs/guides/developer-guide/getting-started) first. If you also want to handle webhook requests, you need to create a [webhook secret](https://docs.lemonsqueezy.com/api/webhooks) too. See the section below for tips on how to generate the webhook secret. Once you have these, you can configure them in e.g. your `runtime.exs` like this:

```elixir
import Config

config :lemon_ex, 
  api_key: System.get_env("LEMONSQUEEZY_API_KEY"),
  webhook_secret: System.get_env("LEMONSQUEEZY_WEBHOOK_SECRET")
```

If you don't provide a valid API key, you will receive `401: Unauthorized` error responses.

## Making Requests

Every LemonSqueezy `object` has its own `context`. The contexts implement basic CRUD endpoints where available. Every CRUD endpoint returns either the object as a struct (e.g. `LemonEx.Variants.Variant`) or a `PaginatedResponse`. For example, the `variant` object has the context `LemonEx.Variants` which implements a `get/1` and `list/1` function. You can simply call these functions like so:

```elixir
iex> LemonEx.Variants.get(variant_id)
{:ok, %LemonEx.Variants.Variant{}}

iex> LemonEx.Variants.list()
{:ok, %LemonEx.PaginatedResponse{data: [%LemonEx.Variants.Variant{}]}}
```

You can find all defined objects in the LemonSqueezy API [docs](https://docs.lemonsqueezy.com/help).

## Handling Webhook Events

To handle Webhook Events coming from LemonSqueezy, you first have to [set up a webhook](https://app.lemonsqueezy.com/settings/webhooks/). You can generate a webhook secret with:

```elixir
# Generate a webhook signing secret with - by default - 40 characters:
iex> LemonEx.Webhooks.gen_signing_secret()
"ppeSr0unsIMx9ynlilgi0PrekwizK46PjVH/Pi2g"

# Generate a webhook signing secret of 8 characters
iex> LemonEx.Webhooks.gen_signing_secret(8)
"g1NZjc9h"

# Use the generator logic directly, with:
iex> 40 |> :crypto.strong_rand_bytes() |> Base.encode64() |> binary_part(0, 40)
"QgxcfhK39h7PJrfkQkvJ4D2rhwNrfQ1yadjb996q"
```

Once you set up your webhook, you need to create a module that will handle the events. Like this for example:

```elixir
defmodule MyAppWeb.MyWebhookHandler do
  @behaviour LemonEx.Webhooks.Handler

  @impl true
  def handle_event(%LemonEx.Webhooks.Event{name: "order_created"} = event) do
  # The event.meta holds all provided meta-data, also custom_data.
    %{"customer_id" => customer_id} = event.meta["custom_data"]

    # The event.data holds the object of the event, like e.g. an `LemonEx.Orders.Order{}`.
    new_order = event.data

    # do something with the new order

    # Return either :ok or {:error, error_message}
    :ok
  end

  # You need to handle all incoming events. So, better have a
  # catch-all handler for events that you don't want to handle,
  # but only want to acknowledge.
  @impl true
  def handle_event(_unhandled_event), do: :ok
end
```

Next, you have to add the `LemonEx.Webhooks.Plug` to your `endpoint.ex` like this:

```elixir
# In your endpoint.ex

plug LemonEx.Webhooks.Plug,
  at: "/webhook/lemonsqueezy", # <- At which path the Plug expects to receive webhooks
  handler: MyAppWeb.MyWebhookHandler # <- Your handler module

# Make sure that this plug comes after the LemonEx plug.
plug Plug.Parsers
```

And that's it!

## List with Filter

When fetching all elements using `list/1`, you can add an optional filter, like this:

```elixir
# Without any filters
LemonEx.Customers.list()

# With both, email and store_id filter
LemonEx.Customers.list(email: "foo@bar.com", store_id: 12345)

# With only email filter or only store_id filter
LemonEx.Customers.list(email: "foo@bar.com")
LemonEx.Customers.list(store_id: 12345)
```

## Todos

- [x] Add all schema objects
- [x] Add optional filters to requests
- [x] Add webhook plug and handler
- [x] Write better docs
- [ ] Allow fetching the next and previous page through `PaginatedResponse`
- [ ] Allow drop-in of other HTTP libraries
- [ ] Add schema tests

## Notes

- The timestamps are mostly snake case but sometimes camelCase (e.g. File or User object)