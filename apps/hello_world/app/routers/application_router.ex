defmodule ApplicationRouter do
  use CouchGears.Router

  Code.require_file "../../../lib/active_resource/active_resource.ex", __FILE__

  get "/" do
    doc = ActiveResource.find("kiosk-mini", "medianet:track:10000017") # CouchGears.AppUtils.get_doc_id_from_doc("labeled","id")
    res = doc.__methods__.field(:title, doc)
    conn.resp_body(res)
  end
end
