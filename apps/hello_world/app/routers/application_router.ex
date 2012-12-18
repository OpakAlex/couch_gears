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
    doc = ActiveResource.CouchDocument.get("kiosk-mini","medianet:track:10000017")
    conn.resp_body([{:ok, doc.fields_to_json([:_id, :_rev, :type])}], :json)
  end
end
