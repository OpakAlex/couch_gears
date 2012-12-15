defmodule HelloWorldApplication do
  use CouchGears

  config :gear,
  # The dbs that enabled for application
  known_db: :all


  config :dynamo,
  # Compiles modules as they are needed
  compile_on_demand: true,

  # Reload modules after they are changed
  reload_modules: true,

  # The environment this Dynamo runs on
  env: Mix.env,

  # The endpoint to dispatch requests too
  endpoint: ApplicationRouter

end
