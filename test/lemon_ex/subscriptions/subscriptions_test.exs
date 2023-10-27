defmodule LemonEx.SubscriptionsTest do
  use ExUnit.Case, async: false

  import Mock
  import Support.Fixtures, only: [load_json: 1]

  test "list" do
    with_mock HTTPoison, get: succesful_response("api/v1/subscriptions_list") do
      assert LemonEx.Subscriptions.list() == expected_subscription_list()
    end
  end

  test "get" do
    with_mock HTTPoison, get: succesful_response("api/v1/subscriptions_get") do
      assert LemonEx.Subscriptions.get(169_590) == expected_subscription()
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

  defp expected_subscription_list do
    {:ok,
     %LemonEx.PaginatedResponse{
       meta: %{
         page: %{current_page: nil, from: 1, last_page: nil, per_page: nil, to: 2, total: 2}
       },
       links: %{
         first:
           "https:\\/\\/api.lemonsqueezy.com\\/v1\\/subscriptions?page%5Bnumber%5D=1&page%5Bsize%5D=10&sort=-createdAt",
         last:
           "https:\\/\\/api.lemonsqueezy.com\\/v1\\/subscriptions?page%5Bnumber%5D=1&page%5Bsize%5D=10&sort=-createdAt",
         next: nil,
         prev: nil
       },
       data: [
         %LemonEx.Subscriptions.Subscription{
           id: "169590",
           store_id: 34567,
           order_id: 1_487_261,
           order_item_id: 1_450_500,
           product_id: 121_004,
           variant_id: 139_405,
           product_name: "App Pro",
           variant_name: "App Pro Monthly",
           user_name: "Liza May",
           user_email: "liza@example.com",
           customer_id: 1_406_493,
           status: "active",
           status_formatted: "Active",
           pause: nil,
           cancelled: false,
           trial_ends_at: nil,
           billing_anchor: 27,
           urls: %{
             customer_portal:
               "https:\\/\\/mystore.lemonsqueezy.com\\/billing?expires=1698434430&user=1461055&signature=27b0921cc4b6a37bc5caed624bc5dbaa44d374e26e892544421668561b8ff0f5",
             update_payment_method:
               "https:\\/\\/mystore.lemonsqueezy.com\\/subscription\\/169590\\/payment-details?expires=1698499230&signature=18cbb5bfc703292df67d0f3528e533e396115096a404bb1876c895805956a959"
           },
           renews_at: "2023-11-27T07:32:22.000000Z",
           ends_at: nil,
           created_at: "2023-10-27T07:32:24.000000Z",
           updated_at: "2023-10-27T07:32:25.000000Z",
           test_mode: true,
           card_brand: "visa",
           card_last_four: "4242"
         },
         %LemonEx.Subscriptions.Subscription{
           id: "169586",
           store_id: 34567,
           order_id: 1_487_247,
           order_item_id: 1_450_485,
           product_id: 121_004,
           variant_id: 139_405,
           product_name: "App Pro",
           variant_name: "App Pro Monthly",
           user_name: "Liza May",
           user_email: "liza@example.com",
           customer_id: 1_406_493,
           status: "active",
           status_formatted: "Active",
           pause: nil,
           cancelled: false,
           trial_ends_at: nil,
           billing_anchor: 27,
           urls: %{
             customer_portal:
               "https:\\/\\/mystore.lemonsqueezy.com\\/billing?expires=1698434430&user=1461055&signature=27b0921cc4b6a37bc5caed624bc5dbaa44d374e26e892544421668561b8ff0f5",
             update_payment_method:
               "https:\\/\\/mystore.lemonsqueezy.com\\/subscription\\/169586\\/payment-details?expires=1698499230&signature=56a13a38f81e8d6592c2d28f379183add6b00f0034188437b919f97752f96ef8"
           },
           renews_at: "2023-11-27T07:27:27.000000Z",
           ends_at: nil,
           created_at: "2023-10-27T07:27:29.000000Z",
           updated_at: "2023-10-27T07:27:31.000000Z",
           test_mode: true,
           card_brand: "visa",
           card_last_four: "4242"
         }
       ]
     }}
  end

  defp expected_subscription() do
    {:ok,
     %LemonEx.Subscriptions.Subscription{
       id: "169590",
       store_id: 34567,
       order_id: 1_487_261,
       order_item_id: 1_450_500,
       product_id: 121_004,
       variant_id: 139_405,
       product_name: "App Pro",
       variant_name: "App Pro Monthly",
       user_name: "Liza May",
       user_email: "liza@example.com",
       customer_id: 1_406_493,
       status: "active",
       status_formatted: "Active",
       pause: nil,
       cancelled: false,
       trial_ends_at: nil,
       billing_anchor: 27,
       urls: %{
         customer_portal:
           "https://mystore.lemonsqueezy.com/billing?expires=1698445809&user=1461055&signature=d0accab17db6cd5fbd9243dd5b57afd131972d61ad81284d26b0dbfcc5e91119",
         update_payment_method:
           "https://mystore.lemonsqueezy.com/subscription/169590/payment-details?expires=1698510609&signature=09c4d3759f6e0c5124e3ab9714e0c87ba0a9ca3f19d73d30c8f81622ac15d9f2"
       },
       renews_at: "2023-11-27T07:32:22.000000Z",
       ends_at: nil,
       created_at: "2023-10-27T07:32:24.000000Z",
       updated_at: "2023-10-27T07:32:25.000000Z",
       test_mode: true,
       card_brand: "visa",
       card_last_four: "4242"
     }}
  end
end
