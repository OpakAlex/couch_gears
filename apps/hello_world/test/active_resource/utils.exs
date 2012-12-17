defmodule ActiveResourceTest do
  def find(db_name, id) do
    body = [{"_id","medianet:album:100049"},
                 {"_rev","2-15b8b3f4238233b35136c35b7db049e7"},
                 {"type","album"},
                 {"title","Simple Gifts"},
                 {"genre","Classical/Opera"},
                 {"label","Capitol Catalog"},
                 {"duration","38:05"},
                 {"release_date","10-25-1990"},
                 {"total_tracks",14},
                 {"last_updated",1348551435},
                 {"artist","Christopher Parkening"},
                 {"artist_id","6079"},
                 {"artist_uri","medianet:artist:6079"},
                 {"_attachments", {[{
                   "track.preview.mp3",{[
                     {"content_type", "audio/mpeg"},
                     {"revpos", 6},
                     {"digest", "md5-hX1sGYK4WZoc6spoD1wf0w=="},
                     {"length", 486703},
                     {"stub", true}
                   ]}
                 }]}}]
    ActiveResource.CouchDocument.parse_to_record(body, "labeled")
  end
end