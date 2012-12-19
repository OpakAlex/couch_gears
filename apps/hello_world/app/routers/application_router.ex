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
    design_document = ActiveResource.DesignDocument.get("labeled", "_design/tracks")
    design_document.create_view(:all, {"map", "function(doc) { if (doc.type == 'track') emit(null, {_id: doc._id}) }"})
    doc = ActiveResource.CouchDocument.get("labeled","medianet:album:100135")
    res = [{:ok, doc.fields_to_json([:_id, :_rev, :type])}]
    conn.resp_body(res, :json)
  end
end
