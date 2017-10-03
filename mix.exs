defmodule Bamboo.EEx.Mixfile do
  use Mix.Project

  def project do
    [
      app: :bamboo_eex,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [ :logger ]
    ]
  end

  defp deps do
    [
      { :bamboo, ">= 0.8.0 and < 1.0.0" },
      # dev
      { :ex_doc, ">= 0.0.0", only: [ :dev ] }
    ]
  end

  defp elixirc_paths(:test), do: [ "lib", "test/support" ]
  defp elixirc_paths(_env),  do: [ "lib" ]

  defp package() do
    %{
      maintainers: [ "Anthony Smith" ],
      licenses: [ "MIT" ],
      links: %{
        GitHub: "https://github.com/sticksnleaves/bamboo_eex"
      }
    }
  end
end
