defmodule HelloWorldApplication.Mixfile do
  use Mix.Project

  def project do
    [ app: :hello_world_application,
      version: "0.1.0.dev",
      compile_path: "tmp/ebin",
      dynamos: [HelloWorldApplication],
      compilers: [:elixir, :dynamo, :couch_gears, :app],
      source_paths: ["lib", "app", "config"],
      env: [prod: [compile_path: "ebin"]],
      deps_path: "../../../couch_gears/deps",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  defp deps do
    [{:couch_gears, "0.1.0.dev", path: "../../../couch_gears"}]
  end
end
