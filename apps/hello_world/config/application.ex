defmodule HelloWorldApplication do
  use CouchGears

  config :gear,
  # The dbs that enabled for application
  known_db: :all


  config :dynamo,
  # Compiles modules as they are needed
  # compile_on_demand: true,
  # Reload modules after they are changed
  # reload_modules: true,

  # The environment this Dynamo runs on
  env: CouchGears.env,

  # The endpoint to dispatch requests too
  endpoint: ApplicationRouter


  # The environment's specific options
  environment "dev" do
    config :dynamo, compile_on_demand: true, reload_modules: true
  end

  environment %r(prod|test) do
    config :dynamo, compile_on_demand: true, reload_modules: false
  end
end
