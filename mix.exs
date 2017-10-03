defmodule Bamboo.EEx.Mixfile do
  use Mix.Project

  def project do
    [
      app: :bamboo_eex,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [ :logger ]
    ]
  end

  defp deps do
    [
      { :bamboo, ">= 0.8.0 and < 1.0.0" }
    ]
  end
end
