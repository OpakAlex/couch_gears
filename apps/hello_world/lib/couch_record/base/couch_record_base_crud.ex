defmodule CouchRecord.Base.CRUD do
  defmacro __using__([]) do
    quote do

      defexception Save.Error, [reason: nil] do
        def message(exception) do
          "#{exception}"
        end
      end

      def put(key, value, rec) do
        if rec.attr?(key) do
          update(key, value, rec)
        else
          create(key, value, rec)
        end
      end

      def remove(key, rec) do
        body = remove_field(key, rec)
        save_record(body, rec)
      end

      def rename(name, new_name, rec) do
        value = rec.attrs[name]
        body = remove_field(name, rec)
        rec = rec.body(body)
        create(new_name, value, rec)
      end

      def remove_document(rec) do
        mark_as_delete(rec)
        rec
      end

      def save!(rec) do
        case CouchRecord.Db.save!(rec.db_name, rec.to_json()) do
          :ok -> true
          _ -> raise Save.Error, reason: "you have some errors in you document"
        end
      end

      def save(rec) do
        case CouchRecord.Db.save!(rec.db_name, rec.to_json()) do
          :ok -> rec
          _ -> false
        end
      end

      def mark_as_delete(rec) do
        save_record(rec.body ++ [{"_deleted", true}], rec)
      end

      def remove_field(key, rec) do
        List.keydelete(rec.body, to_binary(key), 0)
      end

      #private

      defp create(key, value, rec) do
        body = rec.body ++ to_binary_field([{key, value}])
        save_record(body, rec)
      end

      defp update(key, value, rec) do
        body = remove_field(key, rec)
        body = body ++ [{to_binary(key), value}]
        save_record(body, rec)
      end



    end

  end
end