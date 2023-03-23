# LemonEx

## Installation

```elixir
def deps do
  [
    {:lemon_ex, "~> 0.1.0"}
  ]
end
```

### Making Requests

Every LemonSqueezy `object` has its own `context`. The contexts implement basic CRUD endpoints where available. Every CRUD endpoint returns either the object as a struct (e.g. `LemonEx.Variants.Variant`) or a `PaginatedResponse`. For example, the `variant` object has the context `LemonEx.Variants` which implements a `get/1` and `list/1` function. You can simply call these functions like so:

```elixir
iex> LemonEx.Variants.get(variant_id)
{:ok, %LemonEx.Variants.Variant{}}

iex> LemonEx.Variants.list()
{:ok, %LemonEx.PaginatedResponse{data: [%LemonEx.Variants.Variant{}]}}
```

You can find all defined objects in the LemonSqueezy API [docs](https://docs.lemonsqueezy.com/help).

### List with Filter

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

### Todos

- [x] Add all schema objects
- [x] Add optional filters to requests
- [ ] Add webhook controller
- [ ] Add raw-body plug
- [ ] Write better docs
- [ ] Allow fetching the next and previous page through `PaginatedResponse`
- [ ] Allow drop-in of other HTTP libraries

### Notes

- The timestamps are mostly snake case but sometimes camelCase (e.g. File or User object)
- 