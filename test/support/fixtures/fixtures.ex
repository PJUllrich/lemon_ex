defmodule Support.Fixtures do
  def load_json(name) do
    path = Path.expand("../fixtures/#{name}.json", __DIR__)
    raw = File.read!(path)
    json = Jason.decode!(raw)
    {json, raw}
  end
end
