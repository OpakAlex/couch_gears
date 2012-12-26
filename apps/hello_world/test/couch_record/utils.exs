defmodule CouchRecord.Db do
  use CouchRecord.Db.Settings, [db_name: nil]

  def get_doc(db_name, id) do
    parse_to_record(get_body(id), db_name, id)
  end

  def save!(db_name, body) do
    :ok
  end

  def new(db_name) do
    settings.db_name(db_name)
  end

  def db_exist?(db_name) do
    case db_int(db_name) do
      :no_db_file -> false
      _ -> true
    end
  end

    def db_int(db_name) do
      true
    end

    def db_int(db_name, false) do
      :no_db_file
    end

    def parse_to_record(body, db_name, id) do
      if Regex.match?(%r/^_design/, id) do
        CouchRecord.Design.Document.parse_to_record(body, db_name)
      else
        CouchRecord.Document.parse_to_record(body, db_name)
      end
    end


  defp get_body(id) do
    if Regex.match?(%r/^_design/, id) do
      [{"_id", "_design/tracks"},
        {"_rev", "9-dda4fe303d3d1a5fe3c06ab38928a70c"},
        {"views",
                 {[{"all",
                    {[{"map",
                       "function(doc) { if (doc.type == 'track') emit(null, {_id: doc._id}) }"}]
                  }},
                  {"any",
                      {[{"map",
                         "function(doc) { if (doc.type == 'track') emit(null, {_id: doc._id}) }"}]
                    }},
                  ]}
      },
      {"shows",
               {[{"one",
                  {[{"map",
                     "function(doc) { if (doc.type == 'track') emit(null, {_id: doc._id}) }"}]
                }},
                {"two",
                    {[{"map",
                       "function(doc) { if (doc.type == 'track') emit(null, {_id: doc._id}) }"}]
                  }},
                ]}
    },
    {"lists",
             {[{"list1",
                {[{"map",
                   "function(doc) { if (doc.type == 'track') emit(null, {_id: doc._id}) }"}]
              }},
              {"list2",
                  {[{"map",
                     "function(doc) { if (doc.type == 'track') emit(null, {_id: doc._id}) }"}]
                }},
              ]}
  }]
    else
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
end