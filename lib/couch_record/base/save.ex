defmodule CouchRecord.Base.Save do
  @moduledoc """
  mixins for save methods in CouchRecord.Document and CouchRecord.Design.Document
  """
  defmacro __using__([]) do
    quote do
      @doc """
      saves document to couchdbdb, returns true if save success and raise error in not save
      """
      def save!(rec) do
        case rec.save do
          false -> raise SaveError
          _ -> true
        end
      end

      @doc """
      returns document record if save success and false in not save
      """
      def save(rec) do
        rec = apply_changes(rec)
        case CouchRecord.Db.save!(rec.db_name, rec.to_json()) do
          :ok -> rec
          _ -> false
        end
      end

      @doc """
      returns couchdb touple fron HashDict with CRUD changes
      """
      def apply_changes(rec) do
        rec.body(dict_to_list(rec.attrs))
      end

    end
  end
end