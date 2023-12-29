## v0.2.1

* Set all dependencies to version `>= 0.0.0` to prevent version conflicts with applications that use the library.

## v0.2.0

* *BREAKING* Move `filter` parameters for all `list`-calls to a `filter: [...]`-option.
  * If you previously filtered record with e.g. `Customers.list(name: "test@test.com")` you now have to wrap the filters with a `filter`-option like `Customers.list(filter: [name: "test@test.com"])`
* Add `page` parameter to `list`-calls.
  * For example, `Customers.list(page: [size: 2, number: 5])` will return page 5 with page_size 2. You can combine it filters and other parameters like so: `Customers.list(filter: [name: "Peter Ullrich"], page: [size: 2, number: 5], sort: "-name")`

## v0.1.7

* Add `customer_portal` to `Customer.urls`

## v0.1.6
* Upgrade HTTPoison to `2.1`
* Add `request_options` to the config. You can set any HTTPoison options here and they will be respected in all HTTP requests.

## v0.1.5

* Add `urls` and `customer_id` to `Order`