defmodule LemonEx.Webhooks.Handler do
  @callback handle_event(event :: LemonEx.Webhooks.Event.t()) ::
              :ok | {:error, reason :: binary()}
end
