defmodule CouchRecord.Db.Settings do
  defmacro __using__(opts) do
    quote do

      defrecordp :settings, unquote(opts)

      def db_name(settings(db_name: db_name)) do
        db_name
      end

      def db_name(db_name, rec) do
        settings(rec, db_name: db_name)
      end

      def open(doc_id, rec) do
        CouchRecord.Db.open({rec.db_name, doc_id})
      end

      def get(doc_id, rec) do
        rec.open(doc_id)
      end

      def exist?(rec) do
        CouchRecord.Db.db_exist?(rec.db_name)
      end

      def exist?(doc_id, rec) do
        case rec.open(doc_id) do
          :no_db_file -> false
          :not_found -> false
          body -> true
        end
      end

      def int(rec) do
        CouchRecord.Db.db_int(rec.db_name)
      end

    end
  end
end

defmodule CouchRecord.Db do
  use CouchRecord.Db.Settings, [db_name: nil]

  defdelegate get(prop), to: CouchRecord.Db, as: open(prop)

  def new(db_name) do
    settings.db_name(db_name)
  end

  def db_exist?(db_name) do
    case db_int(db_name) do
      :no_db_file -> false
      db -> true
    end
  end

  def open({db_name, id}) do
    case db_int(db_name) do
      :no_db_file -> :no_db_file
      db ->
        case :couch_db.open_doc(db, id) do
          {:ok, doc} ->
            {body} = :couch_doc.to_json_obj(doc, [])
            parse_to_record(body, db_name, id)
          {:not_found, :missing} -> :not_found
        end
    end
  end

  def save!(db_name, body) do
    case db_int(db_name) do
      :no_db_file -> :no_db_file
      db -> :couch_db.update_doc(db, :couch_doc.from_json_obj({body}),[])
    end
  end

  def db_int(db_name) do
    case :couch_db.open_int(to_binary(db_name), []) do
      {:not_found, :no_db_file} -> :no_db_file
      {_, db} -> db
    end
  end

  def parse_to_record(body, db_name, id) do
    if Regex.match?(%r/^_design/, id) do
      CouchRecord.Design.Document.parse_to_record(body, db_name)
    else
      CouchRecord.Document.parse_to_record(body, db_name)
    end
  end

end