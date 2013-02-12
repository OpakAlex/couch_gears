defmodule CouchRecord.Db.Settings do
  @moduledoc """
  works with db record in couchdb
  returns document record based in HashDict
  """
  defmacro __using__(opts) do
    quote do

      defrecordp :settings, unquote(opts)

      @doc """
      returns db_name from record
      """
      def db_name(settings(db_name: db_name)) do
        db_name
      end

      @doc """
      sets db_name to record
      """
      def db_name(db_name, rec) do
        settings(rec, db_name: db_name)
      end

      @doc """
      returns document record based on couchdb document
      """
      def open(doc_id, rec) do
        CouchRecord.Db.open({rec.db_name, doc_id})
      end

      def open(doc_id, rec, rev) do
        CouchRecord.Db.open({rec.db_name, doc_id, rev})
      end

      def get(doc_id, rec) do
        rec.open(doc_id)
      end

      def get(doc_id, rec, rev) do
        rec.open(doc_id, rev)
      end

      @doc """
      returns true if db exist in couchdb; else - false
      """
      def exist?(rec) do
        CouchRecord.Db.db_exist?(rec.db_name)
      end

      @doc """
      returns true in document exist in couchdb; else - false
      """
      def exist?(doc_id, rec) do
        case rec.open(doc_id) do
          :no_db_file -> false
          :not_found -> false
          body -> true
        end
      end

      @doc """
      returns couchdb db record
      """
      def int(rec) do
        CouchRecord.Db.db_int(rec.db_name)
      end
    end
  end
end

defmodule CouchRecord.Db do
  @moduledoc """
  use settings record, for working with couchdb databases and documents
  """
  use CouchRecord.Db.Settings, [db_name: nil]

  defdelegate get(prop), to: CouchRecord.Db, as: open(prop)

  defrecord RevInfo, Record.extract(:rev_info, from: "couch_db.hrl")

  @doc """
  returns new settings record
  """
  def new(db_name) do
    settings.db_name(db_name)
  end

  @doc """
  returns true if db exist in couchdb; else - false
  """
  def db_exist?(db_name) do
    case db_int(db_name) do
      :no_db_file -> false
      db -> true
    end
  end

  @doc """
  returns document record based on couchdb document
  """
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

  def open({db_name, id, rev}) do
    case db_int(db_name) do
      :no_db_file -> :no_db_file
      db ->
        case :couch_db.open_doc(db, id, [RevInfo.new(rev: rev)]) do
          {:ok, doc} ->
            {body} = :couch_doc.to_json_obj(doc, [])
            parse_to_record(body, db_name, id)
          {:not_found, :missing} -> :not_found
        end
    end
  end

  @doc """
  save document in db
  """
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

  @doc """
  returns CouchRecord.Document or CouchRecord.Design.Document from couchdb document touple
  """
  def parse_to_record(body, db_name, id) do
    if CouchRecord.Base.Helpers.is_design?(id) do
      CouchRecord.Design.Document.parse_to_record(body, db_name)
    else
      CouchRecord.Document.parse_to_record(body, db_name)
    end
  end

end