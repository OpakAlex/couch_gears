defmodule CouchGears.Mixfile do
  use Mix.Project

  def project do
    [ app: :couch_gears,
      version: "0.5",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [applications: [:dynamo]]
  end

  # Returns the list of dependencies in the format:
  defp deps do
    [{:dynamo, "0.1.0.dev", github: "josevalim/dynamo"}]
  end
end
