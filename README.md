# LemonEx

## Installation

```elixir
def deps do
  [
    {:lemon_ex, "~> 0.1.0"}
  ]
end
```

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
- [ ] Allow drop-in of other HTTP libraries
- [ ] Write better docs

### Notes

- The timestamps are mostly snake case but sometimes camelCase (e.g. File or User object)
- 