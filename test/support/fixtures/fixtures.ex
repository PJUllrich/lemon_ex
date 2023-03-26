defmodule Support.Fixtures do
  def load_json(name) do
    path = Path.expand("../fixtures/#{name}.json", __DIR__)
    File.read!(path)
  end
end
