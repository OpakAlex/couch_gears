defmodule CouchRecord.Base.CRUD do
  defmacro __using__([]) do
    quote do

      defexception Save.Error, [reason: nil] do
        def message(exception) do
          "#{exception}"
        end
      end

      def put(key, value, rec) do
        rec = rec.attrs(Dict.put(rec.attrs, key, value))
        apply_changes(rec)
      end

      def remove(key, rec) do
        rec = rec.attrs(Dict.delete(rec.attrs, key))
        apply_changes(rec)
      end

      def rename(name, new_name, rec) do
        value = rec.attrs[name]
        rec = rec.attrs(Dict.delete(rec.attrs, name))
        rec.put(new_name, value)
      end

      def remove_document(rec) do
        rec.put(:_deleted, true)
      end

      def save!(rec) do
        case CouchRecord.Db.save!(rec.db_name, rec.to_json()) do
          :ok -> true
          _ -> raise Save.Error, reason: "you have some errors in your document"
        end
      end

      def save(rec) do
        case CouchRecord.Db.save!(rec.db_name, rec.to_json()) do
          :ok -> rec
          _ -> false
        end
      end
    end
  end
end