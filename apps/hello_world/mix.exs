defmodule HelloWorldApplication.Mixfile do
  use Mix.Project

  def project do
    [ app: :hello_world,
      version: "0.1.0.dev",
      compilers: [:elixir, :app],
      deps_path: "../../../couch_gears/deps",
      deps: deps ]
  end

  defp deps do
    [{:couch_gears, "0.1.0.dev", path: "../../../couch_gears"}]
  end
end
