# path = File.expand_path("../couch_document.ex", __FILE__)
# Code.load_file path

defmodule Utils do
  import CouchDocument

  def find(db_name, id) do
    case :couch_db.open_doc(get_db(db_name), id) do
      {ok, doc} ->
        {body} = :couch_doc.to_json_obj(doc, [])
        parse_to_record(body, db_name)
      _ -> :not_found
    end
  end

  # def find(db_name, id) do
  #     if id == "medianet:album:100049" do
  #       {body} = {[{<<"_id">>,<<"medianet:album:100049">>},
  #              {<<"_rev">>,<<"2-15b8b3f4238233b35136c35b7db049e7">>},
  #              {<<"type">>,<<"album">>},
  #              {<<"title">>,<<"Simple Gifts">>},
  #              {<<"genre">>,<<"Classical/Opera">>},
  #              {<<"label">>,<<"Capitol Catalog">>},
  #              {<<"duration">>,<<"38:05">>},
  #              {<<"release_date">>,<<"10-25-1990">>},
  #              {<<"total_tracks">>,14},
  #              {<<"last_updated">>,1348551435},
  #              {<<"artist">>,<<"Christopher Parkening">>},
  #              {<<"artist_id">>,<<"6079">>},
  #              {<<"artist_uri">>,<<"medianet:artist:6079">>}]}
  #     else
  #       {body} = {[{<<"_id">>,<<"medianet:artist:6079">>},
  #              {<<"_rev">>,<<"2-15b8b3f4238233b35136c35b7db049e7">>},
  #              {<<"type">>,<<"artist">>},
  #              {<<"name">>,<<"Artist Test">>}]}
  #     end
  #       parse_to_record(body, db_name)
  #   end

  def save_to_db(db_name, body) do
    db = get_db(db_name)
    :couch_db.update_doc(db, :couch_doc.from_json_obj({body}),[])
  end

  defp get_db(db_name) do
    {_, db} = :couch_db.open_int(to_binary(db_name), [])
    db
  end
end