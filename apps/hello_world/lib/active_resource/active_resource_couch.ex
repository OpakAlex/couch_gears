defmodule ActiveResource.Couch do
  def get(db_name, id) do
    case :couch_db.open_doc(get_db(db_name), id) do
      {ok, doc} ->
        {body} = :couch_doc.to_json_obj(doc, [])
        ActiveResource.CouchDocument.parse_to_record(body, db_name)
      _ -> :not_found
    end
  end

  def save_to_db(db_name, body) do
    db = get_db(db_name)
    :couch_db.update_doc(db, :couch_doc.from_json_obj({body}),[])
  end

  defp get_db(db_name) do
    {_, db} = :couch_db.open_int(to_binary(db_name), [])
    db
  end
end