defmodule LemonEx.CustomersTest do
  use ExUnit.Case, async: false

  import Mock
  import Support.Fixtures, only: [load_json: 1]

  test "list" do
    with_mock HTTPoison, get: succesful_response("api/v1/customers_list") do
      assert LemonEx.Customers.list() == expected_customers_list()
    end
  end

  test "get" do
    with_mock HTTPoison, get: succesful_response("api/v1/customers_get") do
      assert LemonEx.Customers.get(1_406_556) == expected_customer()
    end
  end

  defp succesful_response(json_file) do
    fn _url, _params, _headers ->
      {:ok,
       %HTTPoison.Response{
         status_code: 200,
         body: load_json(json_file)
       }}
    end
  end

  defp expected_customers_list do
    {
      :ok,
      %LemonEx.PaginatedResponse{
        data: [
          %LemonEx.Customers.Customer{
            created_at: "2023-10-14T17:52:43.000000Z",
            id: "1406556",
            status: "subscribed",
            status_formatted: "Subscribed",
            store_id: 48264,
            test_mode: true,
            updated_at: "2023-10-14T17:52:44.000000Z",
            city: nil,
            country: "ES",
            country_formatted: "Spain",
            email: "liza@example.com",
            mrr: 3600,
            mrr_formatted: "$36.00",
            name: "Liza May",
            region: nil,
            total_revenue_currency: 0,
            total_revenue_currency_formatted: "$0.00"
          },
          %LemonEx.Customers.Customer{
            created_at: "2023-10-14T17:35:40.000000Z",
            id: "1406493",
            status: "subscribed",
            status_formatted: "Subscribed",
            store_id: 48264,
            test_mode: true,
            updated_at: "2023-10-27T07:32:25.000000Z",
            city: nil,
            country: nil,
            country_formatted: nil,
            email: "joe@example.com",
            mrr: 14400,
            mrr_formatted: "$144.00",
            name: "Joe Burns",
            region: nil,
            total_revenue_currency: 0,
            total_revenue_currency_formatted: "$0.00"
          }
        ],
        links: %{
          first:
            "https://api.lemonsqueezy.com/v1/customers?page%5Bnumber%5D=1&page%5Bsize%5D=10&sort=-createdAt",
          last:
            "https://api.lemonsqueezy.com/v1/customers?page%5Bnumber%5D=1&page%5Bsize%5D=10&sort=-createdAt",
          next: nil,
          prev: nil
        },
        meta: %{
          page: %{current_page: nil, from: 1, last_page: nil, per_page: nil, to: 2, total: 2}
        }
      }
    }
  end

  defp expected_customer() do
    {
      :ok,
      %LemonEx.Customers.Customer{
        created_at: "2023-10-14T17:52:43.000000Z",
        id: "1406556",
        status: "subscribed",
        status_formatted: "Subscribed",
        store_id: 48264,
        test_mode: true,
        updated_at: "2023-10-14T17:52:44.000000Z",
        city: nil,
        country: "ES",
        country_formatted: "Spain",
        email: "liza@example.com",
        mrr: 3600,
        mrr_formatted: "$36.00",
        name: "Liza May",
        region: nil,
        total_revenue_currency: 0,
        total_revenue_currency_formatted: "$0.00"
      }
    }
  end
end
