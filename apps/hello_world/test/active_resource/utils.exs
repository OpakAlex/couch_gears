defmodule ActiveResource.Couch do
  defdelegate parse_to_record(body, db_name), to: ActiveResource.CouchDocument

  def get(db_name, id) do
    parse_to_record(get_body(), db_name)
  end

  def save_to_db(db_name, body) do
    :ok
  end

  defp get_body do
    [{"_id","medianet:album:100049"},
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
  end
end