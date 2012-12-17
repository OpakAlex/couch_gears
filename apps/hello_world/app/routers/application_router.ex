defmodule ApplicationRouter do
  use CouchGears.Router

  # Application level filters

  # Sets CouchGears backend version info as a 'Server' response header
  # filter CouchGears.Filters.ServerVersion

  # Sets 'application/json' by default
  filter CouchGears.Filters.ResponseTypeJSON

  # Accepts only 'application/json' requests. Otherwise, returns a 'Bad Request' response
  # filter CouchGears.Filters.OnlyRequestTypeJSON


  get "/" do
    doc = ActiveResource.Main.find("kiosk-mini","medianet:track:10000017")
    conn.resp_body([{:ok, doc.__methods__.with_fields([:_id, :_rev], doc, :to_json)}], :json)
  end
end
